## zendev-scripts
A collection of tools to make [Zenoss](http://www.zenoss.com/) development easier.

Currently this is limited to a combination of scripts that make working with ZenPacks easier. Due to extensive namespacing, ZenPacks currently have very deep directory structures such as $ZENHOME/ZenPacks/ZenPacks.zenoss.HttpMonitor/ZenPacks/zenoss/HttpMonitor/ before you get to the real files you'll be editing. See the usage section below for how these tools help.

### Requirements
* bash
* Python

### Installation
These steps should be performed as the `zenoss` user on your system.
1. `cp zpt zendev.sh $ZENHOME/bin`
2. `echo "source $ZENHOME/bin/zendev.sh" >> ~/.bashrc`
3. Edit $ZENHOME/bin/zendev.sh and set the ZENPACKSOURCES to any directories where you have ZenPacks stored. The installed ZenPacks will automatically be found.
4. Logout of the zenoss user, then back in. This will setup the new environment.

### Usage
You never need to invoke the `zpt` script directly. It is really only intended to be invoked by the `zp` tool to do the heavy lifting of locating all of the ZenPacks (installed and not) on your system.

The `zp` command has built-in tab completion. So you can begin to explore its possibilities just by typing `zp <tab><tab>`. Below are some of the possibilities. You can also tab complete the names of the ZenPacks beginning with any portion of the namespace.

* `zp cd HttpMonitor<tab>`
	
	Changes to the typical working directory within the specified ZenPack. This would be.
	
* `zp cdr HttpMonitor<tab>`
	
	Changes to the root directory of a ZenPack. This is really only useful because it contains the setup.py file that you occasionally need to modify.
* `zp mate HttpMonitor<tab>`
	
	[Textmate](http://macromates.com/) is my favorite editor. Running this command will open the typical working directory of the ZenPack in a Textmate project.
	
* `zp mater HttpMonitor<tab>`
	
	Open the root directory of the ZenPack in Textmate.
	
* `zp install HttpMonitor<tab>`
	
	Installs the specified ZenPack.
	
* `zp remote HttpMonitor<tab>`
	
	Removes the specified ZenPack. Will only tab complete currently installed ZenPacks.
