echo $GIST_TOKEN > ~/.gist
touch /all/master
cd /all;
for mdmn in `cat master_list`;do
    mdmnp=`echo "$mdmn" | tr ':/*.' '_'`; 
    mkdir results_$mdmnp;
    python3 ofa/oneforall.py run --takeover True --brute False --target $mdmn --path results_$mdmnp;
    RESPATH=results_$mdmnp;
    mv $RESPATH/all*.txt $RESPATH/init;
    echo '--------\n' >> $RESPATH/init;
    # gist-paste $RESPATH/init -f "$mdmn"__`date +%s`    
    cat $RESPATH/init > /all/master
done
cat /all/ofa/results/takeover* > takeovers
python3 gag.py /all/opt
comm -13 <(sort < /all/opt) <(sort < /all/master) > /all/final
gist-paste /all/final -f `date +%s`    
gist-paste takeovers -f "takeovers"_`date +%s`    
