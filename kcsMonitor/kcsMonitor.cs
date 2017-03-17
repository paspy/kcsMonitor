using System;
using System.IO;
using System.Text;
using System.Collections.Generic;
using Paspy.kcsMonitor.Modules;
using Paspy.kcsMonitor.Utility;

namespace Paspy.kcsMonitor {
    public class kcsMonitor {

        public static void Main(string[] args) {
            Encoding.RegisterProvider(CodePagesEncodingProvider.Instance);
            var dataPath = Path.Combine(Directory.GetCurrentDirectory(), "data");
            Directory.CreateDirectory(dataPath);
            if (File.Exists(dataPath + "/kcsMonitor.log")) {
                Directory.CreateDirectory(Path.Combine(dataPath,"logbak"));
                File.Move(dataPath + "/kcsMonitor.log", dataPath + "/logbak/kcsMonitor_" + DateTime.Now.ToFileTimeUtc() + ".log");
            }
            try {
                InitCLParser();
                m_clParser.ParseCommandLine(args);
            } catch (Exception) {
                Console.WriteLine("Usage: kcsMonitor -t <tokens.xml>");
                return;
            }
            Utils.Log("Welcome to kcsMonitor Senka Collector standalone version", "Main", ConsoleColor.Yellow);
            Utils.Log("Press r to immediately start waiting module. Press q to exit.", "Main", ConsoleColor.Yellow);
            var tokenFilesArg = m_clParser.Arguments.Find(x => x.ShortName == 't') as CommandLineParser.Arguments.ValueArgument<string>;

            BaseModule sm = new SenkaModule();
            do {
                if (Console.ReadKey(true).Key == ConsoleKey.R) {
                    if (Console.ReadKey(true).Key == ConsoleKey.R) sm.Restart();
                    if (Console.ReadKey(true).Key == ConsoleKey.T) sm.ReportTime();
                }
            } while (Console.ReadKey(true).Key != ConsoleKey.Q);
            Utils.Log("Rua.", "Main");
        }

        static CommandLineParser.CommandLineParser m_clParser = new CommandLineParser.CommandLineParser();
        static void InitCLParser() {
            var tokenFilesArg = new CommandLineParser.Arguments.ValueArgument<string>('t', "tokens", "Tokens file, xml only") {
                Optional = true,
                AllowMultiple = false
            };
            m_clParser.Arguments.Add(tokenFilesArg);
        }

    }
}
