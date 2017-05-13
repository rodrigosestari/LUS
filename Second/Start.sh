#!/bin/bash
export PYTHONPATH=rnn_slu/is:$PYTHONPATH.
config=$1


echo "START"

part_1="result/"
part_3=".txt"
part_4="_"

part_5="rnn_slu/data/"
part_6='rnn_slu/config_'
part_7='.cfg'
pelman='elman'
pjordan='jordan'


train='rnn_slu/data/NLSPARQL.train.data'
test='rnn_slu/data/NLSPARQL.test.data'
lex='rnn_slu/data/A.lex'
label='rnn_slu/data/POS.counts'
jordantrain='rnn_slu/lus/rnn_jordan_train.py'
 jordantest='rnn_slu/lus/rnn_jordan_test.py'
configfile=$part_6$config$part_7



filemodel_elman='rnn_slu/data/model_elman_'
filemodel_jordan='rnn_slu/data/model_jordan_'
test_out_elman='rnn_slu/data/test_out_elaman_'
test_out_jordan='rnn_slu/data/test_out_elaman_'

fileresult_elman=$part_1$pelman$part_4$config$part_7
fileresult_jordan=$part_1$pjordan$part_4$config$part_7

./files.sh rnn_slu/data/NLSPARQL.train.data rnn_slu/data/NLSPARQL.test.data 75



if [ $config -ge 0 ]; 
then

	filemodel_elman=$filemodel_elman$config
	filemodel_jordan=$filemodel_jordan$config
	test_out_elman=$test_out_elman$config$part_3
	test_out_jordan=$test_out_jordan$config$part_3
	fileresult_elman=$part_1$pelman$part_4$config
	fileresult_jordan=$part_1$pjordan$part_4$config

	echo "Files:" 
	echo $configfile
	echo $filemodel_elman
	echo $filemodel_jordan
	echo $test_out_elman
	echo $test_out_jordan
	echo $fileresult_elman
	echo $fileresult_jordan
	echo "rnn_slu/data/train.txt  rnn_slu/data/valid.txt  $lex $label $configfile $filemodel_elman"
	

	echo "Training Elman config: $config" 
	python rnn_slu/lus/rnn_elman_train.py rnn_slu/data/train.txt  rnn_slu/data/valid.txt  $lex $label $configfile $filemodel_elman
	
	echo "Training Jordan config: $config" 
	python rnn_slu/lus/rnn_jordan_train.py rnn_slu/data/train.txt  rnn_slu/data/valid.txt $lex $label $configfile $filemodel_jordan

	echo "Test Elman config: $config" 
	python rnn_slu/lus/rnn_elman_test.py rnn_slu/data/train.txt  $test $lex $label  $configfile $test_out_elman > $fileresult_elman

	echo "Test Jordan config: $config" 
	python rnn_slu/lus/rnn_jordan_test.py rnn_slu/data/train.txt  $test $lex $label  $configfile $test_out_jordan > $fileresult_jordan

else
	#method
	for s in {1..1}
	do
		config=$s
		configfile=$part_6$config$part_7
		filemodel_elman='rnn_slu/data/model_elman_'
		filemodel_jordan='rnn_slu/data/model_jordan_'
		test_out_elman='rnn_slu/data/test_out_elaman_'
		test_out_jordan='rnn_slu/data/test_out_elaman_'	

		filemodel_elman=$filemodel_elman$config
		filemodel_jordan=$filemodel_jordan$config
		test_out_elman=$test_out_elman$config$part_3
		test_out_jordan=$test_out_jordan$config$part_3
		fileresult_elman=$part_1$pelman$part_4$config
		fileresult_jordan=$part_1$pjordan$part_4$config

	
		echo "Files:" 
		echo $configfile
		echo $filemodel_elman
		echo $filemodel_jordan
		echo $test_out_elman
		echo $test_out_jordan
		echo $fileresult_elman
		echo $fileresult_jordan


		echo "Training Elman config: $config" 
		python rnn_slu/lus/rnn_elman_train.py rnn_slu/data/train.txt  rnn_slu/data/valid.txt  $lex $label $configfile $filemodel_elman
				
		echo "Training Jordan config: $config" 
		python rnn_slu/lus/rnn_jordan_train.py rnn_slu/data/train.txt  rnn_slu/data/valid.txt $lex $label $configfile $filemodel_jordan

		echo "Test Elman config: $config" 
		python rnn_slu/lus/rnn_elman_test.py rnn_slu/data/train.txt  $test $lex $label  $configfile $test_out_elman > $fileresult_elman

		echo "Test Jordan config: $config" 
		python rnn_slu/lus/rnn_jordan_test.py rnn_slu/data/train.txt  $test $lex $label  $configfile $test_out_jordan > $fileresult_jordan

	done
fi

echo "END"
