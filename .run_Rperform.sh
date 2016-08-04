if [ "$TRAVIS_PULL_REQUEST" == "false" ]; then
  echo -e "Starting to update gh-pages\n"

  # Setup git
  git config --global user.email $USER_EMAIL
  git config --global user.name $USER_NAME

  # Run the Rperform functions
  touch temp_Rperform.R
  echo "Rperform::plot_webpage(test_directory = \"./tests/\", metric = \"time\", output=\"testing\")" >> temp_Rperform.R
  Rscript temp_Rperform.R
  rm temp_Rperform.R
  rm testing.Rmd

  # We copy the generated html file to one level above the current directory (repo) in order
  # to easily move it to the gh-pages directory (which we will download later)
  mv -Rf testing.html ../index.html
  # Store the original location (repo to be tested) and go up one level
  pushd ./
  cd ..

  # Using token clone gh-pages branch
  git clone --quiet --branch=gh-pages https://${GH_TOKEN}@github.com/${TRAVIS_REPO_SLUG}  gh-pages > /dev/null

  # Copy the generated html file to the gh-pages branch and preserve the existing files
  cd ./gh-pages
  if [! -f index.html]
  then
    mv -Rf index.html index_old.html
  fi
  cp -Rf ../index.html index_buildnum${TRAVIS_BUILD_NUMBER}.html
  cp index_buildnum${TRAVIS_BUILD_NUMBER}.html index.html

  # Add, commit and push files to the gh-pages branch
  git add -f .
  git commit -m "Travis build $TRAVIS_BUILD_NUMBER pushed to gh-pages"
  git push -fq origin gh-pages > /dev/null

  popd
  echo -e "Done magic with Rperform\n"
fi

if [ "$TRAVIS_PULL_REQUEST" != "false" ]; then
  echo -e "Starting to update gh-pages for the PR\n"
  # echo -e "$ORIGIN_BRANCH"

  #go to home and setup git
  # cd $HOME
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis"

  #using token clone gh-pages branch
  # git clone --quiet --branch=gh-pages https://${GH_TOKEN}@github.com/da-ta-vinci21/Rperform_ggplotly.git  gh-pages > /dev/null
  # git clone --quiet --branch=master https://${GH_TOKEN}@github.com/da-ta-vinci21/Rperform_ggplotly.git  master > /dev/null
  # git clone --quiet --branch=$ORIGIN_BRANCH https://${GH_TOKEN}@github.com/da-ta-vinci21/Rperform_ggplotly.git  origin > /dev/null

  pushd ./
  cd ..

  #Run the Rperform functions
  touch temp_Rperform.R
  echo "Rperform::plot_PR_webpage(\"./tests/unattached.R\", metric = \"time\")" >> temp_Rperform.R
  Rscript temp_Rperform.R
  rm temp_Rperform.R
  rm PR.Rmd

  git clone --quiet --branch=gh-pages https://${GH_TOKEN}@github.com/analyticalmonk/directlabels.git  gh-pages > /dev/null

  # git checkout -- *

  cd ./gh-pages
  cp -Rf ../index.html index.html
  #
  # #add, commit and push files
  git add -f .
  git commit -m "Travis build $TRAVIS_BUILD_NUMBER pushed to gh-pages"
  git push -fq origin gh-pages > /dev/null

  popd
  echo -e "Done magic with Rperform and PR\n"
fi
