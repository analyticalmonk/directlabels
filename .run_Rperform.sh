if [ "$TRAVIS_PULL_REQUEST" == "false" ]; then
  echo -e "Starting to update gh-pages\n"

  #go to home and setup git
  # cd $HOME
  # git config --global user.email "travis@travis-ci.org"
  # git config --global user.name "Travis"

  #using token clone gh-pages branch
  # git clone --quiet --branch=gh-pages https://${GH_TOKEN}@github.com/"{your_repo_here}"  gh-pages > /dev/null
  # git clone --quiet --branch=master https://${GH_TOKEN}@github.com/"{your_repo_here}"  master > /dev/null

  #go into master directory and run the Rperform functions
  # cd master
  # if [! -f temp_Rperform.R]
  # then
    touch temp_Rperform.R
    echo "Rperform::plot_metrics(\"./tests/unattached.R\", metric = \"time\")" >> temp_Rperform.R
  # fi
  Rscript temp_Rperform.R
  rm temp_Rperform.R

  # git checkout -- *

  # cd ../gh-pages
  # if [! -f index.html]
  # then
  #   mv -Rf index.html index_old.html
  # fi
  # cp -Rf $HOME/master/index.html index_buildnum{$TRAVIS_BUILD_NUMBER}.html
  # cp index_buildnum${TRAVIS_BUILD_NUMBER}.html index.html
  #
  # #add, commit and push files
  # git add -f .
  # git commit -m "Travis build $TRAVIS_BUILD_NUMBER pushed to gh-pages"
  # git push -fq origin gh-pages > /dev/null

  echo -e "Done magic with Rperform\n"
fi

if [ "$TRAVIS_PULL_REQUEST" != "false" ]; then
  echo -e "Starting to update gh-pages for the PR\n"
  # echo -e "$ORIGIN_BRANCH"

  #go to home and setup git
  # cd $HOME
  # git config --global user.email "travis@travis-ci.org"
  # git config --global user.name "Travis"

  #using token clone gh-pages branch
  # git clone --quiet --branch=gh-pages https://${GH_TOKEN}@github.com/da-ta-vinci21/Rperform_ggplotly.git  gh-pages > /dev/null
  # git clone --quiet --branch=master https://${GH_TOKEN}@github.com/da-ta-vinci21/Rperform_ggplotly.git  master > /dev/null
  # git clone --quiet --branch=$ORIGIN_BRANCH https://${GH_TOKEN}@github.com/da-ta-vinci21/Rperform_ggplotly.git  origin > /dev/null

  pushd ./
  cd ..

  #Run the Rperform functions
  touch temp_Rperform.R
  echo "Rperform::compare_PR(\"./tests/unattached.R\", metric = \"time\")" >> temp_Rperform.R
  Rscript temp_Rperform.R
  rm temp_Rperform.R

  # git checkout -- *

  # cd ./gh-pages
  # cp -Rf $HOME/index.html index.html
  #
  # #add, commit and push files
  # git add -f .
  # git commit -m "Travis build $TRAVIS_BUILD_NUMBER pushed to gh-pages"
  # git push -fq origin gh-pages > /dev/null

  popd
  echo -e "Done magic with Rperform and PR\n"
fi
