#!/bin/bash

COBERTURA=cobertura-2.1.1
SLF4J=slf4j/slf4j-api-1.7.28.jar
INSTRUMENTED=instrumented
REPORTDIR=cobertura_report

rm -rf $INSTRUMENTED
rm -rf $REPORTDIR
rm -rf cobertura.ser
mkdir -p $INSTRUMENTED
mkdir -p $REPORTDIR

echo Instrument the classes that we want to check coverage on
$COBERTURA/cobertura-instrument.sh src/MindRoad/*.class --destination $INSTRUMENTED || exit

echo Run the tests
java -ea -cp $SLF4J:$COBERTURA/$COBERTURA.jar:$INSTRUMENTED:testng-6.8/testng-6.8.jar:test org.testng.TestNG -verbose 2 test/test.xml

echo Generate report
$COBERTURA/cobertura-report.sh --format xml --destination $REPORTDIR src

echo Check coverage
$COBERTURA/cobertura-check.sh --branch 0

