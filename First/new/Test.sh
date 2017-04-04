test = $1
#test = '../data/NLSPARQL.test.data'

cat $test | cut -f 2 > ../data/tok_actual.txt
#cat $test | cut -f 2 | sed 's/^ *$/#/g' | tr "\n" " "  | tr "#" "\n" > ../data/tok_sentences_eactual_line.txt
cat $test | cut -f 1  > ../data/sentences.txt
cat $test | cut -f 1 | sed 's/^ *$/#/g' | tr "\n" " "  | tr "#" "\n" > ../data/sentences_line.txt

while read line
do
	python textToFst_unk.py $line > ../data/testFST.txt	
	echo "$line"
    fstcompile --isymbols=../data/A.lex --osymbols=../data/A.lex ../data/testFST.txt > ../data/testFST.fst	
	fstcompose ../data/testFST.fst ../data/transducer.fst | fstcompose - ../data/pos.lm | fstrmepsilon | fstshortestpath > ../data/line.fst
	fstprint --isymbols=../data/A.lex --osymbols=../data/A.lex --fst_align ../data/line.fst | sort -r -g | cut -f 4 >> ../data/tok_predicted.txt
done < ../data/sentences_line.txt

paste ../data/sentences.txt ../data/tok_actual.txt ../data/tok_predicted.txt | sed '/^ *$/d' | tr "\t" "#" | sed 's/##//g' | sed 's/#/_T-/g' | tr "_" "\t" 

# Evaluation
#perl test.pl -d " " < ../data/output.txt