open OUnit
open BoardTest
open CamelThemedEmojiFormatterTest
open ColorFormatterTest
open ConsoleArgsFunctorTest
open ConsoleIOFunctorTest
open EmojiFormatterTest
open EngineTest
open FormatterTest
open GameFunctorTest
open HumanFunctorTest
open InputFunctorTest
open MainFunctorTest
open MinimaxTest
open MatrixTest
open MinimaxTest
open OTokenTest
open OutputFunctorTest
open PlayerFunctorTest
open RandomMoveTest
open SpookyScaryHalloweenFormatterTest
open TypesTest
open UtilTest
open XTokenTest

let verbose = ref true

let tests =
    OUnit.TestList
      [
        BoardTest.tests;
        CamelThemedEmojiFormatterTest.tests;
        ColorFormatterTest.tests;
        ConsoleArgsFunctorTest.tests;
        ConsoleIOFunctorTest.tests;
        EmojiFormatterTest.tests;
        EngineTest.tests;
        FormatterTest.tests;
        GameFunctorTest.tests;
        HumanFunctorTest.tests;
        InputFunctorTest.tests;
        MainFunctorTest.tests;
        MatrixTest.tests;
        MinimaxTest.tests;
        OTokenTest.tests;
        OutputFunctorTest.tests;
        PlayerFunctorTest.tests;
        RandomMoveTest.tests;
        SpookyScaryHalloweenFormatterTest.tests;
        TypesTest.tests;
        UtilTest.tests;
        XTokenTest.tests;
      ]

let _ = run_test_tt_main tests
