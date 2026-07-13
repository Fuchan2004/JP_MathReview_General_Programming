# JP_MathReview_General_Programming
This Github Repository was created for the General Programming class of the JP Summer Math Review. This class is based on the Environmental Bioinformatics class tought by Harriet Alexander, Maria Pachiadaki, and Carolyn Tepolt as well as on the course material compiled by Pad Poemnamthip.


*Created by: Fadime Stemmer, 2026/07/12*

## Goals
1. The Unix Shell Intro
   * Open the terminal on our local machine
   * Test commands for navigating around our files via the command line
2. Introduction to the HPC
   * Introduction to HPC
   * Remote machine access (ssh) and log on to the HPC
   * Navigating the HPC using command line
   * Transfering files and folders from your local computer to HPC
3. Github
   * Setup Git on your local computer (or HPC)
   * Git commands - how to set up and work on a (collaborative) project
4. Writing scripts, slurm, sbatch
   * Getting onto compute Nodes using srun
   * Bash scripts
   * Submitting jobs using slurm scripts and sbatch

## 1. The Unix Shell Introduction
### Open the terminal on your local machine
* If you have a Mac computer, just open Terminal and test by typing:
```
echo "hello world"
```
* If you have a Windows computer open PowerShell as Administrator (right-click Start → "Terminal (Admin)" or search "PowerShell", right-click, Run as Administrator).
	* 	Run `wsl --install`
	* 	Restart your computer when prompted.
	* 	After restart, open the new **Ubuntu** app from the Start menu, set a username/password when asked.
	* 	Test by typing:
```
echo "hello world"
```
### Test commands for navigating around our files via the command line

<img width="690" height="362" alt="image" src="https://github.com/user-attachments/assets/2c2c641a-b293-4d58-b900-d2e0da75ecea" />

This figure shows you the general structure of a command prompt in unix shell. A command has four parts: 
* The **prompt**: indicates that the shell is waiting for input.
* The **command**: indicates the action that you would like the computer to do.
* The **options**: options are great ways to customize your commands. Each command has a set of options you can use. You can find resources online, use the command `man [ENTER COMMAND YOU NEED HELP WITH]` or use the option `--help` to explore options.
* The **arguments**: indicate the file or folder that you would like the command to work on.

Lets first check out which files are in our directory using the `ls` command. The option `-F` tells ls to classify the output by adding a marker to file and directory names to indicate what they are:
* a trailing / indicates that this is a directory
* @ indicates a link
* * indicates an executable

```
ls -F
```

Now let's check where you are on your computer! You can find out which directory you are currently in by using `pwd` which translates to "Print working directory".
```
pwd
```
Lets make a directory on your current working directory called `math_review_2026` using the command `mkdir`. Then list your working directory again. Can you find the directory we just created? 
```
mkdir mathreview2026
```

If you want to change the working directory, use the command `cd` which means change directory. 
```
cd mathreview2026
```
Useful arguments to navigate: 
* `./`: Indicates your current working directory
* `../`: Indicates one directory up
* `~`: Indicates the home directory (the uppermost directory)

There are many more useful commands to learn and navigate in unix shell. I highly recommend [this software carpentries tutorial](https://swcarpentry.github.io/shell-novice/index.html) that walks you through basic operations, loops, writing scripts etc. in detail. 

## 2. Introduction to the HPC
### Logging on to the HPC
This is a remote cluster of computers (it isn't really that remote.. it is in the basement of Clark). Nearly all command line systems (BASH etc.) have Secure Shell (ssh) natively installed. ssh is a cryptographic network protocol that provides a secure channel over an unsecured network. ssh can be used to log on to any number of platforms such as: remote computers (like a lab computer), computer clusters or high performance computers (HPCs), computers running in the cloud (e.g. AWS), etc.

Today we will be using ssh to log onto poseidon.whoi.edu. To do this you will need to know what your WHOI username is and be within WHOI's firewall either by connecting to the local network (e.g. eduroam) or by logging into WHOI's vpn.

Once you are logged on to WHOI's network you should be ready to ssh. You can do that using the `ssh` command with your username@poseidon.whoi.edu like here: 
```
ssh <username>@poseidon.whoi.edu
```
Poseidon has 2 login nodes: l1 and l2. We can select which node we would like to login. (Normally it's not needed, but in some case it might.)
```
ssh <username>@poseidon-l1.whoi.edu
ssh <username>@poseidon-l2.whoi.edu
```

If this is your first time logging onto the network you will see a prompt like the following:
```
	Host key not found from the list of known hosts.
	Are you sure you want to continue connecting (yes/no)?
```
This is a safety protocol ensuring that you do indeed want to add this address to a list of known hosts. Type `yes`.

You should now be prompted for your password (this will be your WHOI email password):
```
Host 'poseidon.whoi.edu' added to the list of known hosts.
      [usernames]'s password:
```
Once you type the correct password you should see something like the following:

```
  ___             _    _             ___ _         _           
 | _ \___ ___ ___(_)__| |___ _ _    / __| |_  _ __| |_ ___ _ _ 
 |  _/ _ (_-</ -_) / _` / _ \ ' \  | (__| | || (_-<  _/ -_) '_|
 |_| \___/__/\___|_\__,_\___/_||_|  \___|_|\_,_/__/\__\___|_|  

Welcome to the Poseidon Cluster at WHOI!

Please remember to copy your files to scratch and move/delete them after each job.
Please do not run anything on the login nodes and submit jobs to SLURM. All running 
jobs/processes on the login nodes will be terminated without notice.
```

**Congratulations! You have logged on to the HPC! This terminal now represents the environment of the remote computer that you just logged on to.**

Look at your prompt. Has it changed? What information do you see now? What do the different parts mean? 
Hint: try using the command `whoami` and the command `hostname`.

### Navigating the HPC using command line

When you login to poseidon/hydra you will land in your personal directory. If you have not worked on the HPC before this folder should be empty. You can check that using the `ls` command.
```
ls 
```

Unlike your local computer where you have the option of navigating through your computer's GUI file navigator (Finder or the like), on the HPC you DO NOT have access to any sort of GUI and you must do everything via the CLI. 

First, lets copy or clone the JP math review repository used in this course to the HPC: 
```
git clone https://github.com/Fuchan2004/JP_MathReview_General_Programming.git
```
List again, what do you see? 
Navigate **into** the newly created folder and list the output. There should be a folder called papers.zip in our repo. You can use the `unzip` command to unzip it:
```
unzip papers.zip
```
Lets list the contents of the papers directory using the `ls` command. Alternatively you can use `ll` (for long list) or explore some flags. These I find useful:  `ls -ltrh`
```
ls papers/
ls -ltrh papers/
```
What do you see?

Tip: If you are typing out the path rather than copying it, try hitting the tab key in the middle of the word or phrase, this should automatically complete the phrase for you or if there is more than one option repeatedly hitting tab will bring up a listing of all options.

### Working with files and directories
#### Creating directories and files
Now, let's navigate back to our `JP_MathReview_General_Programming` folder. In this directory we are going to make a new directory called observations.
```
mkdir observations
```
Since we just made observations there is nothing inside of it-- let's change that!

Move into the directory observations and let's create a file. There are many ways to do this. For now, let's use a text editor. Here we will be using `nano` as it one of the easiest to learn. There are many other more powerful command line text editors (e.g. `vim`, `emacs`, etc.). If you are comfortable with one of those feel free to use it-- otherwise stick with nano.

To create a new text file simply type `nano [name of file]`. For example: 
```
nano 2026-observation.txt
```
This will create a new file called `2026-observation.txt` and you should be automatically be entered into the nano environment. Add some text to the file. And then press `ctrl+O`. This will write the text to the output file. Once you are satisfied you can press `ctrl+X` to exit. Note that the bottom of the nano window lists other ctrl commands that you might want to use with the program.

#### Looking at files (without editing them)
Often we want to get a quick look at the contents of a file without potentially accidentally modifying it. For that, the command `less` is quite useful. 
```
less 2026-observation.txt
```
This should bring you into an interface where you can read and scroll but cannot edit the document. Type `q` to exit.

Another convenient way to examine the content of a file is to print it to the screen or print it to stdout or Standard Output. The program `cat` or concatenate will print the entire contents of a file to the screen. Try it out by typing:
```
cat 2026-observation.txt
```
How is this different than less?

#### Moving and renaming
One of the most common things you will likely find yourself doing is managing and reorganizing files in your projects. Let's go to the folder `papers` we downloaded and unzipepd earlier. Here we have many different versions of a paper that we are struggling to write.

Let's make a new directory called `old-drafts` inside the `papers` directory. We are going to use the command `mv` (move) to move files on the command line. 
`mv` takes two arguments:
* Argument 1: target file that you want to move
* Argument 2: destination or the location that you want to move it to.

Let's move `paper-v1.txt` into `old-drafts/`: 

```
mv ./paper-v1.txt ./old-drafts/
```

The command mv can also be used to rename files. Let's rename `paper-final2.txt` to `paper-DONE.txt`. To do this, your destination is the new name of the file.
```
mv paper-final2.txt paper-DONE.txt
```
Run `ls`. What has happened?

`mv` can also be used with directories. For example, you can change the name of the directory `old-drafts` to `extremely-old-drafts`. Try it out! 

**A word of caution:** You can very easily overwrite files using mv. Let's check this out. What happens if you run:
```
mv paper-v4.txt paper-v3.txt
```
Do you have the same number of files?

#### Copying
The command `cp` (copy) works very similarly to mv. As with `mv` it requires two arguments (the target file you want to copy and the destination/name of the new file). Let's try to create the files that we had previously by copying our final drafts.
```
cp paper-final.txt paper-v1.txt
cp paper-final.txt paper-v2.txt
cp paper-final.txt paper-v3.txt
```
`cp` can also be used with directories. Try copying `extremely-old-drafts` to a new directory called `very-old-drafts`. What happened? For `cp` we need the flag `-r` to be able to copy directories including its contents. 
```
cp -r extremely-old-drafts very-old-drafts
```

**Excercise**

Write a single command to move `paper-v2.txt` to the directory `JP_MathReview_General_Programming/observations/` and rename it `initial-observations.txt`. Now, navigate to `JP_MathReview_General_Programming/observations/` and try copying `paper-v3.txt` to the location where you are without moving directories.

#### Removing Things
On the command line removal is permanent. Removing with the command `rm` just as `cp` and `mv` can take a target file or a list of more than file. So, for example:
```
rm paper-v1.txt
```
removes `paper-v1.txt`. If you run `ls` again you will note that it is gone. And it is truly gone. Short of having backed things up there is no way to get a rm-ed file back. A flag that I like to add (or have aliased) is `rm -i` for interactive. 

Let's try `rm -i` to remove `paper-v2.txt`.
```
rm -i paper-v2.txt
```

You will be asked 
```
rm: remove regular file ‘paper-v2.txt’?
```
Type `y` if you want to remove it and `n` if you don't. It's an added layer of security just in case!

*The danger zone*: You can also use `rm` to remove directories and this is where you really need to be careful. Using the flag `rm -r` will recursively remove *all files within a directory*. I strongly suggest (especially if you are new the the command line) using the `-i` flag. Note: `rmdir` is another option for removing directories the default requires that the directory be empty.

#### Outputs & string commands things together
The real power of shell comes from our ability to string commands together to do something greater.

Navigate into the directory `data`. Type `ls` to familiarize yourself with what we are doing. Again let's use `ls` to look at the files. There are many data files that end in `*.out`. Take a look at one of with `less`.

We are going to use a new command now called `wc` which counts the lines, words, and characters in a file.

Run :
```
wc *.out
```

This is printing information to standard out stdout. This is the default output from many programs - it prints an answer for you on the command line. This answer is not saved anywhere. Within command line we can actively redirect outputs to save it into a file or to pass the output into a new function. Let's check out what that looks like.

Let's run `wc -l *.out` this only counts the lines for each of the files. We can now use the `>` to pass this output to a file. Let's make a file called lengths.
```
wc -l *.out > lengths.txt
```
What happened? Was anything printed to standard out?

`>` writes to a new file. It will overwrite anything present within a file. So if you run a new command and write to `lengths.txt`, it will overwrite the previous output. 
```
wc *.out > lengths.txt
```

`>>` by contrast can be used to *append* to an existing file by adding the output to the end of an existing file.
```
wc -l *.out >> lengths.txt
```

What is more is you can actually pass out to other programs. Let's introduce briefly a couple very useful programs for looking at and dealing with files:

* `wc`: counts the words in the file
* `sort`: sort the contents of a file
* `uniq`: returns only unique values from a file. Requires the file has been sorted
* `head`: returns the head (top) of the file
* `tail` : returns the tail (bottom) of the file
* `cut`: cuts a column of interest based on whatever the delimiter is
* `paste`: pastes columns together
* `cat`: in addition to printing a file to screen it can be used to concatenate files together

These are some of my most used text handling functions that I use. All of them default to outputting to stdout and so can be easily piped together.

So, let's try piping the output of `wc -l` into a new function. Let's try sort so that we can figure out what file has the most lines. To pass the output of one file to the next we use the pipe character `|` (located above the \ on American keyboards). So, we will pass the output of `wc -l` to `sort -n` to get a list of the files sorted based on the numeric value.
```
wc -l *.out | sort -n
```
Now we are looking at a sorted list. We can then programmatically identify the shortest command by piping the output of the above to another command `head -n 1` which will return only the first line of the input.
```
wc -l *.out|sort -n|head -n 1
```
We can then even save this output to a file!
```
wc -l *out|sort -n|head -n 1 > shortest.file
```
You can see how these tools can be endlessly pieced together to do some really powerful manipulations!

### Transfering files and folders from your local computer to HPC
Navigate back to `JP_MathReview_General_Programming`. We are going to use the `scp` command to securely copy files and directories between remote hosts without logging into the remote systems explicitly. The scp command uses SSH to transfer data, so it requires a password or passphrase for authentication. Unlike rcp or FTP, scp encrypts both the file and any passwords exchanged so that anyone snooping on the network cannot view them. We are going to transfer all our paper drafts (ending in `.txt`) from the HPC folder `papers` to a location on your computer.

1. Open a new local terminal
2. Use scp to copy. scp takes two arguments, your origin and your destination. Use pwd if you don't know where you are. To transfer a folder you use the flag -r scp -r origin destination
```
scp  "fadime.stemmer@poseidon.whoi.edu:/vortexfs1/home/fadime.stemmer/JP_MathReview_General_Programming/papers/*.txt" ~/Desktop/CHOOSE_YOUR_DESTIANTION_FOLDER/
```
3. Type in your password

If you want to copy something from your local computer to the HPC you just turn the origin and destination arguments around!
   
Note: the '*' asterisk indicates a wildcard (any character). When the shell sees a wildcard, it expands the wildcard to create a list of matching filenames before running the command. If a wildcard expression does not match any file, Bash will pass the expression as an argument to the command as it is. For example typing `ls *.pdf` here will result in an error message that there is no file called `*.pdf`. Ultimately, it is the shell, not the other programs, that deals with expanding wildcards.

## 3. Github
### What is Git / GitHub?
= software that helps you version control your code. GitHub is a platform that integrates with git and helps you collaborate with others. Be aware: 
* Git is not an archival service
* Git is not a good place to store data or data products (checkout Zenodo or OSF.io instead)

### Set up Git on your computer / the HPC
First, we are going to share a public ssh key between your personal or HPC account and GitHub. 
To do this navigate to ~/.ssh/ and get the contents of the public key file.

```
cd ~/.ssh/
cat id_rsa.pub
```
If you do not have a public key file yet, you can create it as follows: 

```
ssh-keygen -t rsa -b 4096 -C "your_email_from_githubaccount@xyz.edu"
```
You will see a message similar to this: 
```
Generating public/private rsa key pair.
Enter file in which to save the key: ~/.ssh/if_rsa
Enter passphrase: [CHOOSE PASSWORD OR LEAVE EMPTY FOR NO PASSWORD]
Enter same passphrase again: 
Your identification has been saved in ~/.ssh/if_rsa
Your public key has been saved in ~/.ssh/if_rsa.pub
The key fingerprint is:
SHA256:O1vxWxK7SnJaVFYsuCYmkg6YohXuIk9tOQZ5z0hWeu0 fstemmer@mit.edu
The key's randomart image is:
+---[RSA 4096]----+
|           . ..  |
|  .   .   . ...  |
| + o + .   .o.   |
|+ * B o + oo     |
|oo O B +Soo .    |
|+ o O o Eo o o   |
|.+ o .  + = + .  |
|  .      X   =   |
|        o ..o    |
+----[SHA256]-----+
```
Great! Your key is ready to go! Before we move on let's take an additional step to start the SSH agent and load your private key into it, so you don't have to type your key's passphrase every time you use SSH. Within the .ssh/ folder, type: 

```
# Start agent and connect shell
eval "$(ssh-agent -s)"
# Load your private key id_rsa to your running agent.
ssh-add ~/.ssh/id_rsa
```

Finally, copy the ssh key to your clipboard, either by opening the id_rsa.pub file selecting and copying or with following command: 
```
pbcopy < ~/.ssh/id_rsa.pub
```

Now, we are going to provide this public ssh key to GitHub. Go [here](https://github.com/settings/keys) and click on "Add new SSH key" on the top right of the page. Give the key a title that is informative for you (f.e. poseidon) and paste your key into the key box. Now click "Add SSH key" at the bottom and you should be good to go!

### Git commands - how to set up and work on a (collaborative) project
Github is a great platform for working on code both individually or collaboratively. I usually create a repository for each project / paper I work on. To do that visit Github -> Repositories -> New. Select your settings (I recommend working in private mode and then setting to public once you're ready to publish) and click create. Congratualtions, you created your first github repository! 

Lets copy it to our local computer using the command `git clone` as we did before with the math review repo. This is used to clone (or copy) repositories from GitHub to your local machine. Cloning is more than downloading as a zipped file as it will carry with it all the information and metadata that git needs to maintain version control.
1. Navigate to the repository you'd like to clone, click the green code box, select SSH, and copy the link.
2. Switch back to your terminal window.
3. Navigate to the directory you would like to copy this folder into.
4. To clone we will type the command:

```
git clone [PASTE THE LINK YOU COPIED]
```

5. You can then hit enter and you should see some printout like this:

```
Cloning into 'REPO NAME'...
remote: Enumerating objects: 256, done.
remote: Counting objects: 100% (256/256), done.
remote: Compressing objects: 100% (40/40), done.
remote: Total 256 (delta 0), reused 256 (delta 0), pack-reused 0
Receiving objects: 100% (256/256), 29.52 KiB | 0 bytes/s, done.
```

If you now run `ls` you should see a new folder with the name of this repository. Go into this folder and type 
```
ls -a
```

The `-a` flag shows all files (including those that are hidden). Many programs create hidden files (files or folders that start with `.` to prevent users from messing with them).

* You should see the `README.md`. The `.md` is markdown file which is a common and relatively easy to use formatting language. You can learn more about it [here](https://guides.github.com/features/mastering-markdown/).
* You will also see a `.git/` folder. This folder contains all the history associated with this repo. Basically, anything that has been committed to GitHub's memory is encoded within the `.git/` folder.

After a git has been initiated (either via `git init` or `git clone`, as done here) you can start adding files to be tracked. First off, we have our local repo. Fundamentally, git does not automatically track any files. Files within your working directory are not being followed by git.

Let's make a new file in our directory called `temp`. Using nano write something in `temp`, save and then quit out of `nano`.

<img width="2358" height="1493" alt="image" src="https://github.com/user-attachments/assets/dc7b145a-d982-47cc-a0e1-c2acbf86e019" />

To check the status of what files are being followed we can use the command 
```git status```

This tells us what files are being followed, which aren't, and which have been changed. We can see at the bottom that temp is listed as a file that isn't being tracked. To tell git that you want it to follow a file and move it from the working directory to the staging area you use the command:
```
git add temp
```

Now run `git status` again. What changed?

Git isn't really tracking this file yet. To finalize our changes we need to commit them. This will take our temp file that is in the staging area and commit the changes moving it into our local repo. These changes are now remembered by git.

```
git commit
```
You will be prompted to enter a commit message. Type something in, then save and exit the text editor. Your commit message should be something that helps you remember what you did. Its a great way to version control your code and find specific changes. 

Type `git status` again and see what has changed.

Now, what if we make a change to `temp`. Use `nano` to add some text to `temp`.

What happens when you type `git status`?

As you can see it says that `temp` is tracked-- but it isn't staged staged. In order to stage the file you have to run `git add` and `git commit` again.

Linking local Git to a remote (like GitHub)
What if we now wanted to share our changes that we made on our local repo with a remote system like GitHub? There are three main ways of interacting with the remote:
* `git clone`: we already used this. This will copy a version of the repo to your local system.
* `git pull`: copies changes from a remote repository to a local repository.
* `git push`: copies changes from a local repository to a remote repository.

We have all made some changes to our local repositories. Let's try pushing them to the remote. Generally, it is good practice (and can save you a lot of trouble such as losing files) to run `git pull` first just in case there have been any changes. This will help you avoid conflicts between the local and remote repository.

```
git pull
```

Run `git status`. You can see we are on our `main` branch. Main is the name of the remote repository. By convention, the local is typically called `origin`. So, to push our current commits to main we will type:

```
git push origin main
```

Go and take a look at your remote - you should see that the file temp has been added to your online repository.

**A parting thought on Git**
Starting out with git can be a bit overwhelming at times. It is easy to mess up your repo or the like.

*Two common problems*:
- Accidentally adding files that are over the 100 MB size limit and trying to push them to GitHub.
- Conflicting pushes: if you made any changes to your remote Git and forgot while trying to push your local. Thus, always try to pull and then push.
And honestly, sometimes you just need to start over. Re-clone, move files around, pull and push. However, the simple fact that you can re-download a version of your project from the internet is very powerful!


## 4. Writing scripts, srun, slurm and sbatch
### Getting onto compute Nodes using srun
Once we use the ssh command to get onto poseidon, we are on the login Note, which is a shared computer. The login node provides a portal to larger computing space and can be used to navigate file structure. But not to be used for large computing. No heavy lifting bioinformatics on login node!

We can get on a computing node using the command `srun [options]`. For example:
```
srun -p scavenger -N 1 -n 1 --mem=10gb --time=02:00:00 --pty bash
```
* `-p`: partition, can be
   * `compute`: compute nodes are shared computing space.
   * `scavenger`: can be used as long as the owner isn´t using it. Scavenges are purchased resources of others
   * `bigmem`: used for memory intensive operations
* `-N`: Number of nodes you need to use
* `-n`: Number of tasks. How many copies of command are allowed to run on the requested resources (for paralellization). Number of cores available to each task are set separately (= cores)
* `--mem`: amount of memory you need to run your scripts
* `--time`: amount of time you request computing allocation for
* `--pty bash`: run bash attached to a pseudo-terminal. Necessary to continue 

Check your prompt - did anything change? 

See all jobs that you or others are running on the HPC nodes using `squeue`. Use the flag `-u [your username]` to show your jobs
```
squeue -u [USERNAME]
```
Cancel all your jobs using `scancel` 
```
scancel -u [USERNAME]
```
or only specific runs: 
```
scancel [JOBID]
```
### Bash Scripts
#### Automation with for loops
Loops are a programming construct which allows us to perform a series of commands in the same way for each item in a list. Loops facilitate automation and save you time-- moreover loops reduce the amount of typing required (and mistakes made). So, if you ever find yourself thinking: gosh-- I want to do this one thing to all 10502395 of my files. You should think: for loop.

```
for item in [list]
	[command_to_do_stuff] $item
done
```

The `$` in bash is used to designate variables. A variable name is a name whose value can be changed (rather than a text string or command that is static and cannot be changed. In a for loop the item in a list becomes a variable and changes as it moves through the loop.

Navigate to `fasta/`. Let's pretend we wanted to retrieve the 10th value from `alteromonasmacleodii.fasta` and `pseudomonasputida.fasta` data files. If we tried to do this with our wildcard command and pipes it wouldn't work very well. We can encode this in a for loop.
```
for sequence in alteromonasmacleodii.fasta pseudomonasputida.fasta
do
	head -n 10 ${sequence} | tail -n 1
done
```
What if we wanted to save this out to a file? Modify this to create a file that has the output. This can be done in more than one way.

*Note*: The shell prompt changes to > as we were typing in our loop. This indicates that the terminal is waiting for something to tell it that the command is finished. In this case done.

`echo` is a very useful command-- it is effectively print and will report the value of any variable. For example, we just defined the variable file in the above for loop.
```
echo file #prints the name file
echo ${file} #prints the value of file
```
#### Writing bash scripts
Ultimately, the thing that makes shell so powerful is your ability to save things you want to do more than once. Navigate into the `poseidon_codes` folder.

Here are some ready made scripts that we are going to take a look at. First type ls -l. You should see that all of these scripts are executable.

Let's take a look at `hello.sh`.

As you can see it is pretty straight forward. This is a file that contains one command echo Hello, world.. To the screen.

To execute a bash script, you can use the command `bash`.
```
bash hello.sh
```
This is nice-- but not really the most useful thing in the world. Let's edit this script to allow the user to pass an input to it. There are a series of special variables in shell `$1`, `$2`, etc. These variables correspond to order of the input following the name of the script. The variable `$@` refers to all the variables passed to the script.

Let's change hello.sh so that it will say hello to whatever the input is. Use nano and change the input to:
```
echo Hello $1!
```
We can now execute this by typing:
```
bash hello.sh [your name]
```
What is the output of the above?

**Exercise**
Lets create a new bash script in the scripts folder called `tenth_sequence.sh`. Copy the for loop from earlier that gave us the 10th sequence in a fasta file as output into the script. Modify it to output the 10th sequence from all `*.fasta` files in an input directory (should be $1). Run the script:

```
bash tenth_sequence.sh ../fasta/
```

### Submitting jobs using slurm scripts and sbatch
In the `poseidon_codes` folder you will find two MATLAB scripts called `hello_world.m` and `Testplot_20260713.m`. We will submit these scripts and run them using a compute node without the bash interface using slurm. Slurm is the job scheduler used on the HPC. To run any job on the HPC, we have to submit it via slurm and wait in the queuing system. The nice thing about this is that the job will not be interrupted even if you lose connection to the HPC. 

Here we will work with simple MATLAB codes. First we need to check preloaded modules on the HPC by typing `module list`. Then check the modules available to download on Poseidon by typing `module avail`. We need to load MATLAB. You can do that through: 

```
module load matlab
``` 
Once that is done, lets read and prepare our MATLAB codes with the `nano` text editor. Write anything you like behind the print statement
```
nano hello_world.m
```
Next lets explore job submission through slurm. You will have to write submission scripts to submit jobs with the extension `*.slurm`. Lets look at the slurm script in our folder `job.slurm`. The header in this file looks as follows: 
```
#!/bin/bash
#SBATCH --partition=compute	     # specify the partition
#SBATCH --job-name=matlab        # create a short name for your job
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=1        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem-per-cpu=4G         # memory per cpu-core (4G per cpu-core is default)
#SBATCH --time=00:10:00          # total run time limit (HH:MM:SS)
#SBATCH --mail-type=all          # send email on job start, end and fault
#SBATCH --mail-user=<username>@whoi.edu # email for receiving job status
#SBATCH --output=<jobname_here>%j.log # creates a log file with the specified job name and number (%j)
```
We can submit our job to the compute node and all other specified sections using following command: 
```
sbatch job.slurm
```
Lets check the status of our job:
```
squeue -u <username>
```

**Exercise**
Open the `Testplot_20260713.m`. Read it through, change the function and output filename to your desired filename. Save and exit the file.
Open `job.slurm` and edit the command to run this matlab script. Save and exit. Then submit the job and check for the results. How can we get the output files onto our local computer? 
