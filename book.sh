rm -r BookParts && rm book.pdf

if [ ! -d "BookParts" ]; then
        mkdir BookParts
fi
if [ ! -d "BookParts/new" ]; then
        mkdir BookParts/new
fi

for f in _posts/2023-*;
do
        cp $f BookParts/
done

# copy everything from book-meta/* into book-parts
for f in book-meta/*;
do
        cp $f BookParts/
done

for f in BookParts/*;
do
        file=$(basename $f)
        front_matter=$(sed -n '/---/,/---/p' $f | wc -l)
        # get the title from the front matter that starts with title:
        title=$(sed -n '/title:/p' $f | sed 's/title: //')
        # if "technical writing" is not in the document, skip the file

        doc=$(sed -n '/technical writing/p' $f)
        
        # a-ha moments is a post I want to include
        if [[ $doc != *"a-ha"* ]]; then
                if [[ $doc != *"technical writing"* ]]; then
                        continue
                fi
        fi
        to_remove=("My writing setup" "Coloured cups and teaching" "Blog about what you want" "My year in blogging")
        for i in "${to_remove[@]}"
        do
                if [[ $title == *"$i"* ]]; then
                        continue 2
                fi
        done
        # strip the quotes from the title
        title=$(echo $title | sed 's/"//g')
        image=$(sed -n '/image:/p' $f | sed 's/image: //')
        image=$(echo $image | sed 's/"//g')
        image=$(echo $image | sed 's/ *$//g')
        alt_text=$(sed -n '/image_alt_text:/p' $f | sed 's/image_alt_text: //')
        alt_text=$(echo $alt_text | sed 's/"//g')
        # // remove "advent of technic alwriting" fro mtitle
        title=$(echo $title | sed 's/Advent of Technical Writing: //')

        echo $title

        if [ "$alt_text" != "" ]; then
                image_alt_text=$alt_text
        else
                image_alt_text="[No alt text]"
        fi

        if [ "$image" != "" ]; then
                if [[ $image != *.webp ]]; then
                        echo "![$image_alt_text]($image)\n" >> BookParts/new/$file
                fi
        fi
        echo "# $title\n" >> BookParts/new/$file
        tail -n +$(($front_matter+3)) BookParts/$file >> BookParts/new/$file
        echo "\n\n\pagebreak" >> BookParts/new/$file
done

# move /Documents/Introduction.md to the top of the list
# mv ~/Documents/Introduction.md BookParts/new/2000-introduction.md

# order book parts so they are in this order:
# Part I: The Technical Writer's Role

# My experience starting as a technical writer
# A Day in the Life
# Is writing customer-facing documentation technical writing?

# Part II: Writing Technical Documents

# Types of Documentation
# Implicitly downplaying knowledge in technical communication
# Writing introductions in technical tutorials
# Outlines
# First Sentences
# Clarity
# Jargon
# Style
# Lists
# Placeholders
# Code Snippets
# Effective Examples
# Consistent Examples
# Callout Boxes
# Run-on Sentences
# Duplicate Information
# How-To Outline
# Writing Feature Releases
# Navigation Structure
# Navigation Links
# Technical content and a-ha moments

# Part III: Technical Writing Within a Team

# Authoring Tools
# Deprecating Content
# Facilitating Ideas
# Internal Code Documentation Requirements
# Internal Dry Run
# Holistic Documentation Reviews
# Publishing Contributor Blog Posts
# Reviewing the Wolfram Language Documentation
# Reviewing Digital Ocean's Documentation
# Being a Technical Writer
# Author Bio

# add 1-1, 1-2, etc. to files
for f in BookParts/new/*;
do
        file=$(basename $f)
        file_contents=$(cat $f)
        # echo $file
        # echo $f
        if [[ $file_contents == *"My experience starting as a technical writer"* ]]; then
                mv $f BookParts/new/1000-my-experience-starting-as-a-technical-writer.md
        elif [[ $file_contents == *"A Day in the Life"* ]]; then
                mv $f BookParts/new/1001-a-day-in-the-life.md
        elif [[ $file_contents == *"Is writing customer-facing documentation technical writing?"* ]]; then
                mv $f BookParts/new/1002-is-writing-customer-facing-documentation-technical-writing.md
        elif [[ $file_contents == *"Types of Documentation"* ]]; then
                mv $f BookParts/new/2000-types-of-documentation.md
        elif [[ $file_contents == *"Implicitly downplaying knowledge in technical communication"* ]]; then
                mv $f BookParts/new/2001-implicitly-downplaying-knowledge-in-technical-communication.md
        elif [[ $file_contents == *"Writing introductions in technical tutorials"* ]]; then
                mv $f BookParts/new/2002-writing-introductions-in-technical-tutorials.md
        elif [[ $file_contents == *"Outlines"* ]]; then
                mv $f BookParts/new/2003-outlines.md
        elif [[ $file_contents == *"First Sentences"* ]]; then
                mv $f BookParts/new/2004-first-sentences.md
        elif [[ $file_contents == *"Clarity"* ]]; then
                mv $f BookParts/new/2005-clarity.md
        elif [[ $file_contents == *"Jargon"* ]]; then
                mv $f BookParts/new/2006-jargon.md
        elif [[ $file_contents == *"Style"* ]]; then
                mv $f BookParts/new/2007-style.md
        elif [[ $file_contents == *"Lists"* ]]; then
                mv $f BookParts/new/2008-lists.md
        elif [[ $file_contents == *"Placeholders"* ]]; then
                mv $f BookParts/new/2009-placeholders.md
        elif [[ $file_contents == *"Code Snippets"* ]]; then
                mv $f BookParts/new/2010-code-snippets.md
        elif [[ $file_contents == *"Effective Examples"* ]]; then
                mv $f BookParts/new/2011-effective-examples.md
        elif [[ $file_contents == *"Consistent Examples"* ]]; then
                mv $f BookParts/new
        elif [[ $file_contents == *"Callout Boxes"* ]]; then
                mv $f BookParts/new/2012-callout-boxes.md
        elif [[ $file_contents == *"Run-on Sentences"* ]]; then
                mv $f BookParts/new/2013-run-on-sentences.md
        elif [[ $file_contents == *"Duplicate Information"* ]]; then
                mv $f BookParts/new/2014-duplicate-information.md
        elif [[ $file_contents == *"How-To Outline"* ]]; then
                mv $f BookParts/new/2015-how-to-outline.md
        elif [[ $file_contents == *"Writing Feature Releases"* ]]; then
                mv $f BookParts/new/2016-writing-feature-releases.md
        elif [[ $file_contents == *"Navigation Structure"* ]]; then
                mv $f BookParts/new/2017-navigation-structure.md
        elif [[ $file_contents == *"Navigation Links"* ]]; then
                mv $f BookParts/new/2018-navigation-links.md
        elif [[ $file_contents == *"Technical content and a-ha moments"* ]]; then
                mv $f BookParts/new/2019-technical-content-and-a-ha-moments.md
        elif [[ $file_contents == *"Authoring Tools"* ]]; then
                mv $f BookParts/new/3000-authoring-tools.md
        elif [[ $file_contents == *"Deprecating Content"* ]]; then
                mv $f BookParts/new/3001-deprecating-content.md
        elif [[ $file_contents == *"Facilitating Ideas"* ]]; then
                mv $f BookParts/new/3002-facilitating-ideas.md
        elif [[ $file_contents == *"Internal Code Documentation Requirements"* ]]; then
                mv $f BookParts/new/3003-internal-code-documentation-requirements.md
        elif [[ $file_contents == *"Internal Dry Run"* ]]; then
                mv $f BookParts/new/3004-internal-dry-run.md
        elif [[ $file_contents == *"Holistic Documentation Reviews"* ]]; then
                mv $f BookParts/new/3005-holistic-documentation-reviews.md
        elif [[ $file_contents == *"Publishing Contributor Blog Posts"* ]]; then
                mv $f BookParts/new/3006-publishing-contributor-blog-posts.md
        elif [[ $file_contents == *"Reviewing the Wolfram Language Documentation"* ]]; then
                mv $f BookParts/new/3007-reviewing
        elif [[ $file_contents == *"Reviewing Digital Ocean's Documentation"* ]]; then
                mv $f BookParts/new/3008-reviewing-digital-oceans-documentation.md
        elif [[ $file_contents == *"Being a Technical Writer"* ]]; then
                mv $f BookParts/new/3009-being-a-technical-writer.md
        elif [[ $file_contents == *"Author Bio"* ]]; then
                mv $f BookParts/new/3010-author-bio.md
        fi
done

echo "Ordered files..."

pandoc -s BookParts/new/* -o book.pdf --toc --toc-depth=2 --pdf-engine=xelatex \
        --metadata title="Software Technical Writing: A Guidebook" --metadata author="James (jamesg.blog)" \
        --metadata titlepage=true --metadata toc-own-page=true \
        --metadata lang="en-US" --metadata mainfont="Helvetica" --metadata sansfont="Arial" \
        --metadata fontsize="12pt" \
        --metadata geometry:margin=1in --metadata geometry:a4paper \
        --highlight-style pygments \
        -V links-as-notes=true \
        --from markdown --template ./eisvogel.tex \
        --metadata link-citations=true \
        --metadata citecolor:blue 

# clean up the files
rm BookParts/* && rm -r BookParts/new