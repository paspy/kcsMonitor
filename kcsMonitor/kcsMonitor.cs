using System;
using System.Text;
using System.Collections.Generic;
using Paspy.kcsMonitor.Modules;
using Paspy.kcsMonitor.Utility;

namespace Paspy.kcsMonitor {
    public class kcsMonitor {

        public static void Main(string[] args) {
            Encoding.RegisterProvider(CodePagesEncodingProvider.Instance);

            var sm = new SwfModule(10000);
            do {
                if (Console.ReadKey(true).Key == ConsoleKey.R) sm.Restart();
                if (Console.ReadKey(true).Key == ConsoleKey.T) sm.ReportTime();
            } while (Console.ReadKey(true).Key != ConsoleKey.Q);

            return;
            // above test

            try {
                InitCLParser();
                m_clParser.ParseCommandLine(args);
            } catch (Exception) {
                Console.WriteLine("Usage: kcsMonitor -u [username] -p [password] -a <api_start2> -s <clientSwf>");
                return;
            }
            Utils.Log("Welcome to kcsMonitor. All selected modules will start in few seconds.", "Main", ConsoleColor.Yellow);
            Utils.Log("Press r to immediately start waiting modules. Press q to exit.", "Main", ConsoleColor.Yellow);
            var usrArg = m_clParser.Arguments.Find(x => x.ShortName == 'u') as CommandLineParser.Arguments.ValueArgument<string>;
            var pwdArg = m_clParser.Arguments.Find(x => x.ShortName == 'p') as CommandLineParser.Arguments.ValueArgument<string>;
            var fetArg = m_clParser.Arguments.Find(x => x.ShortName == 't') as CommandLineParser.Arguments.ValueArgument<int>;
            var as2Arg = m_clParser.Arguments.Find(x => x.ShortName == 'a') as CommandLineParser.Arguments.SwitchArgument;
            var swfArg = m_clParser.Arguments.Find(x => x.ShortName == 's') as CommandLineParser.Arguments.SwitchArgument;

            string loginId = usrArg.Value;
            string password = pwdArg.Value;

            List<BaseModule> modules = new List<BaseModule>();

            System.Threading.Thread.Sleep(2000);
            if (as2Arg.Parsed) {
                modules.Add(new ApiStart2Module(loginId, password, fetArg.Parsed ? fetArg.Value : 30000));
            } else if (swfArg.Parsed) {
                modules.Add(new SwfModule(fetArg.Parsed ? fetArg.Value : 30000));
            } else {
                modules.Add(new ApiStart2Module(loginId, password, fetArg.Parsed ? fetArg.Value : 30000));
                modules.Add(new SwfModule(fetArg.Parsed ? fetArg.Value : 30000));
            }

            do {
                if (Console.ReadKey(true).Key == ConsoleKey.R) {
                    foreach (var mod in modules) {
                        mod.Restart();
                    }
                }
            } while (Console.ReadKey(true).Key != ConsoleKey.Q);
            Utils.Log("Rua.", "Main");
        }

        static CommandLineParser.CommandLineParser m_clParser = new CommandLineParser.CommandLineParser();
        static void InitCLParser() {
            var loginIdArg = new CommandLineParser.Arguments.ValueArgument<string>('u', "username", "DMM Login ID") {
                Optional = false,
                AllowMultiple = false
            };
            var pwdArg = new CommandLineParser.Arguments.ValueArgument<string>('p', "password", "DMM Login password") {
                Optional = false,
                AllowMultiple = false
            };

            var fTimeArg = new CommandLineParser.Arguments.ValueArgument<int>('t', "time", "Specify how much waiting time for each monitoring cycle.") {
                Optional = true,
                AllowMultiple = false
            };

            var asArg = new CommandLineParser.Arguments.SwitchArgument('a', "api_start2", "Enable monitor new ships and equipments from api_start2 module.", false) {
                Optional = true,
                AllowMultiple = false,
            };

            var swfArg = new CommandLineParser.Arguments.SwitchArgument('s', "clientSwf", "Enable monitor kancolle client swf files module.", false) {
                Optional = true,
                AllowMultiple = false,
            };
            m_clParser.Arguments.Add(loginIdArg);
            m_clParser.Arguments.Add(pwdArg);
            m_clParser.Arguments.Add(fTimeArg);
            m_clParser.Arguments.Add(asArg);
            m_clParser.Arguments.Add(swfArg);
        }

    }
}
