Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1RM6UO-0004IW-RX; Fri, 04 Nov 2011 00:14:29 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pA3N8KDZ003209;
	Thu, 3 Nov 2011 23:08:20 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 03143-01; Thu,  3 Nov 2011 23:08:16 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pA3N8CcV003202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 3 Nov 2011 23:08:12 GMT
Message-ID: <1320361692.20107.103.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 03 Nov 2011 23:08:12 +0000
X-Mailer: Evolution 3.2.1- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: openembedded-core <openembedded-core@lists.openembedded.org>
Subject: Bitbake 1.14.0 released!
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 03 Nov 2011 23:14:29 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Bitbake 1.14.0 has been released.

http://downloads.yoctoproject.org/releases/bitbake/bitbake-1.14.0.tar.gz

[I've placed the bitbake tarballs onto Yocto infrastructure until OE
infrastructure gets sorted out. Berlios goes away in 7 weeks so I wanted
a backup of them somewhere and I didn't want to hold the release any
further]

This release contains many bugfixes and improvements over 1.12 and
includes hob, a graphical interface to running builds and image
construction. A git log of the differences between 1.12 and 1.14
follows. 

Bernhard Reutner-Fischer (1):
      manual: fix typo

Brandon Stafford (1):
      doc/usermanual.xml: Tweaks for the manual

Chris Larson (50):
      cooker: simplify self.configuration.data vs data usage
      cooker: use BBHandler.inherit for INHERIT
      build: switch to old cwd handling
      build: add missing newline
      bitbake-layers: drop 2.6 from #!, per Joshua Lock
      server: use local fixed _bootstrap when appropriate
      goggle: exit quietly on ^C
      hob: adjust for master's eventHandler API
      lockfile: ask for forgiveness, not permission
      utils: fix typo in lockfile
      bb.siggen: import os
      codeparser: fix ShellSyntaxError usage
      codeparser: use ==, not 'is' to compare strings
      Fix more incorrect usages of 'is'
      More 'is' fixups
      Initial work on getting bitbake working under pypy
      build: add missing bit necessary for mhatle's fakeroot fix
      runqueue: simplify fakeroot environment handling
      build: in exec_func, mkdirhier ${T}
      build: fix dir removal traceback
      build: don't choke if olddir no longer exists
      event: register event handler functions, not code objects
      event: improve output when eventhandler exec fails
      event: improve output for syntax errors in handlers
      cooker: fix -b with BBCLASSEXTEND
      persist_data: raise KeyError on missing elements
      persist_data: add has_key
      persist_data: don't allow non-string keys/values
      persist_data: make SQLTable a context manager
      persist_data: implement comparison, same as dict
      build: run fakeroot if FAKEROOT is set
      bb.namedtuple_with_abc: add useful util from activestate
      bb.exceptions: add code to create pickleable traceback entries
      bb.exceptions: add to_string convenience function
      bb.exceptions: handle tb entries without context
      bb.exceptions: don't show a repr of 'self'
      cooker: show a useful message for ParsingFailure
      cooker: pass traceback back from parsing thread
      cooker: use logger.exception for config file parse errors
      cooker: don't show a useless traceback for SyntaxError
      cooker: don't show a traceback for ParseError
      Shift exception formatting into the UI
      Merge remote branch 'github/exceptions'
      event: don't catch systemexit from handler execution
      cooker: handle ExpansionError the same way we do ParseError
      parse: pass a useful (if mangled) key to bb.data.expand for :=
      siggen: don't choke with traceback when data is None
      bb.exceptions: don't choke on frames without arguments
      Revert the unintentionally pushed msg.py change
      event: fix the event display order when exiting early

Christopher Larson (6):
      fetch.git: fix a remnant wrt persist + keyerror
      msg: use a simpler enumeration for the domains
      msg: fix domain enum use
      cache: fix remnant broken 'info' reference from recent cache changes
      taskdata: fix string formatting of an error message
      codeparser: make var_expands actually hold useful information

Cliff Brake (1):
      Linefeed to test commits

Darren Hart (4):
      correct typo in ??= documentation
      bitbake docs: use dblatex to build the pdf bitbake manual
      fetch2/git: use logging.debug() and clarify messages
      fetch2/git: ensure network check log matches actual command

Denys Dmytriyenko (1):
      lib/bb/providers: make "checking PREFERRED_PROVIDER_%s" a debug message

Dexuan Cui (1):
      bitbake/cooker, bitbake-layers: show the .bbappend files that matches no existing .bb recipe

Dmitry Eremin-Solenikov (1):
      lib/bb/siggen.py: return a string from noop get_taskhash

Dongxiao Xu (3):
      Introduce stamp-extra-info task flag into stamp filenames
      fix parameter order for flaglist()
      data_smart.py: make use of expand cache in getVar()

Holger Hans Peter Freyther (1):
      fetch2/git: Allow to specify the name of the checkout directory

Jessica Zhang (3):
      ui/crumbs/tasklistmodel: fix loading a saved recipe
      ui/crumbs/hobprefs: trigger reparse when package format changed
      bb/ui/hob: Restore toolchain relevant preference settings for build

Joshua Lock (155):
      bitbake/cache: store a list of inherited files in the cache
      implement command to get all possible targets and their dependencies
      implement command to find configuration files for a config variable
      bitbake/cooker: add generateTargetsTree method
      bitbake/cooker: reduce code duplication
      bitbake/[cooker|cache]: cache summary, license and group. Add to targets tree
      introduce crumbs.TaskListModel a gtk.ListStore subclass
      bitbake/event: fix some whitespace issues
      bitbake/crumbs: update documentation header
      bitbake/progress: add method to pulse the progress bar
      bitbake/cooker: don't drop possible_world ref count
      Add new UI hob, a prototype Gtk+ GUI for creating images
      bitbake/progress: make progress dialog modal for parent window
      bitbake/cache: bump cache version after recent changes
      bitbake/ui: Fix Gtk+ GUI's after recent cache changes
      uievent: fix queueing of events for xmlrpc before UI has loaded
      server: add updated/fixed xmlrpc server from Poky
      bitbake/cooker: don't error in prepareTreeData for unbuildable targets
      bitbake/hob: only show one progress dialog when changing machine
      bitbake/depexp: closing progress dialog kills gui
      bitbake/goggle: closing the progress dialog kills the UI
      bitbake/hob: fix cancel button
      command|cooker: allow generating targets tree for specified pkgs
      cooker: add generic method to locate configuration files
      command|cooker|event: add findConfigFilePath command
      cooker|command|event: add new command findFilesMatchingInDir
      cooker: remove code duplication in non trivial functions
      cooker: switch to new universe target rather than world
      bitbake: add -R option for loading configuration files after bitbake.conf
      hob: re-designed interaction and implementation
      ui/crumbs/tasklistmodel: fix reset method
      lib/bb/hob: fix changing base image
      lib/bb/ui/hob: don't error when dismissing save as dialog
      ui/crumbs/tasklistmodel: update brought in by column when possible
      ui/crumbs/tasklistmodel: fix automatic removal of orphaned items
      cooker: only return *Found events if something was actually found
      ui/crumbs/hobprefs: add missing import
      ui/crumbs/tasklistmodel: fix saving recipes
      ui/hob: add more guidance to the stop dialog
      ui/crumbs/configurator: write new lines after new entries
      ui/hob: don't crash if PARALLEL_MAKE doesn't include a space
      ui/crumbs/tasklistmodel: ignore tasks and images when marking dependencies
      hob: refer to tasks as Package Collections
      ui/crumbs/tasklistmodel: don't show native and cross recipes
      ui/hob: clear the search entry when resetting
      ui/hob: if the user clicks Stop a second time only offer 'Force Stop'
      hob: only add new layer's to the UI
      ui/crumbs/hobprefs: set higher arbitrary limit on threads & parallelism
      ui/crumbs/hobprefs: tweak the package format tooltip
      hob: rework image output type setting
      bitbake|cooker: save a copy of the environment when BitBake is started
      data|cooker: use saved environment variables when calling inheritFromOS
      bitbake-layers: adapt to cooker change for saved environment
      command|cooker: Add reparseFiles command
      cooker: only append files once
      ui/hob: replace the ugly static command map
      ui/crumbs/hobeventhandler: reparse files before running other commands
      ui/hob: switch from buildFile to buildTargets for custom image builds
      ui/hob: don't offer to show built output if build fails
      ui/hob: change wording in build complete dialog
      ui/hob: Force the 'Base image combo' to be drawn correctly
      ui/hob: enable building an image with minimal contents
      ui/crumbs/tasklistmodel: handle items added in by base image being removed
      ui/crumbs/tasklistmodel: don't iterate whole model in find_alt_dependency()
      ui/crumbs/tasklistmodel: work around overly aggressive package removal
      hob: fix loading customised image recipe
      cooker: populate rdepends-pkg in generatePkgDepTreeData
      hob: more reliable disabling of GPLv3 packages
      hob: fix save/restore of toolchain preferences
      ui/crumbs/hobeventhandler: remove unused code
      hob: unset busy cursor on exit
      ui/crumbs/hobeventhandler: emit a signal when there's a fatal-error
      ui/hob: show error and exit if we receive the fatal-error signal
      ui/crumbs/hobeventhandler: emit a signal when a command fails
      ui/crumbs/configurator: tweak addLayerConf return values
      ui/crumbs/layereditor: if layer adding fails show an explanatory dialog
      hob: remove temporary directory on program shutdown
      bb/ui/hob: save changes to bblayers.conf when using Add Layer menu item
      bb/ui/crumbs/runningbuild: optionally create list entries sequentially
      bb/ui/hob: show build messages are displayed in the order they're received
      ui/crumbs/runningbuild: add optional readonly mode, default off
      bb/ui/hob: disable editing in the build messages tree view
      bb/ui/crumbs/runningbuild: emit signal when command fails with exit signal
      bb/ui/hob: fix detection of whether GPLv3 is disabled
      bb/ui/crumbs/tasklistmodel: fix regex used for loading image recipes
      bb/ui/hob: prevent label on progress bar from changing rapidly when loading
      bb/ui/crumbs/hobeventhandler: use generic loading message once cache loaded
      bb/ui/hob: only connect to the changed signal of image_combo once
      bb/ui/hob: be clear that the image contents are an estimate
      bb/ui/hob: reset event handler once build complete
      bb/cooker: mark parsed conf files as potential cache invalidators
      bb/ui/crumbs/tasklistmodel: prevent hang when removing item
      bb/ui/hob: move some code around to avert a race
      bb/cooker: only emit ConfigFilePathFound for files which were parsed
      bb/ui/crumbs/tasklistmodel: fix some typos and add comments to mark()
      bb/ui/crumbs/tasklistmodel: correctly uniquify dependency list
      bb/ui/crumbs/tasklistmodel: don't include an item in its own depends
      bb/cache: rename confusing variable
      bb/command|cooker: refactor the reparseFiles logic
      bb/ui/crumbs/hobeventhandler: adapt to reset -> reparse change
      bb/ui/crumbs/configurator: introduce writeConfFile method for all writes
      lib/bb/ui/crumbs/hobprefs: fix erroneous save/reparse
      bb/crumbs/tasklistmodel: filter nativesdk packages out of views
      bb/ui/crumbs/tasklistmodel: include package level information
      bb/ui/crumbs/tasklistmodel: optimise find_path_for_item
      bb/ui/crumbs/tasklistmodel: make package_model_filter a little safer
      bb/ui/crumbs/tasklistmodel: simplify conditional in include_item
      Ensure only the filtered environment variables are inherited from the OS
      bb/ui/crumbs/runningbuild: reduce number of messages after recent msg change
      bb/ui/crumbs/runningbuild: hide the progress bar on cache load complete
      bb/ui/crumbs/tasklistmodel: more robust checking for substrings
      bb/ui/crumbs/tasklistmodel: remove useless items from dependency list
      bb/ui/crumbs/tasklistmodel: store all binb, not just the first
      hob: don't try and build if user selects Bake with no selections made
      bb/ui/crumbs/tasklistmodel: track the PN for each entry in the model
      bb/ui/hob: fix package only build
      bb/ui/crumbs/hobeventhandler: fix return values of *_image_output_type
      bb/ui/crumbs/hobprefs: fix setting IMAGE_FSYTPES
      bb/ui/hob: warn and prevent image build if no IMAGE_FSTYPE is set
      bb/fetch2/git: add checkstatus command
      hob: don't set PARALLEL_MAKE and BB_NUMBER_THREADS based on cpu count
      bb/ui/crumbs/tasklistmodel: fix find_reverse_depends method
      hob: disable some menu entries whilst build is in progress
      ui/crumbs/tasklistmodel: don't add same item to binb column more than once
      ui/crumbs/runningbuild: add a 'Copy' item to the messages right-click menu
      ui/crumbs/tasklistmodel: don't add same item to binb column more than once
      ui/crumbs/tasklistmodel: prevent packages depending on each other
      ui/crumbs/tasklistmodel: optimise find_path_for_item()
      ui/crumbs/tasklistmodel: remove unnecessary check
      ui/crumbs/tasklistmodel: loop optimisation in include_item()
      ui/crumbs/tasklistmodel: don't add empty entries to COL_BINB
      hob: use both pre and post files for hob configuration
      hob: reflect defaultsetup being default distro
      hob: add a test to ensure hob is run with the required pre and post files
      ui/crumbs/hobprefs: disable 'build toolchain with headers'
      ui/crumbs/runningbuild: mask run_buildstats failure
      hob: disable removal of packages
      ui/crumbs/hobeventhandler: fix test for BBFILES
      ui/crumbs/hobeventhandler: don't check BBPATH and BBFILES each build
      hob: correctly handle an exception
      hob: correctly set the selected image when loading a recipe
      fetch2/wget: make checkstatus() quieter
      ui/crumbs/hobprefs: re-enable reloading of data after prefs changes
      hob: fix build again when building packages only
      hob: enable package only builds even if an image has been built
      ui/crumbs/runningbuild: fix log messages right-click menu
      hob: fix opening of image output dir on image build completion
      ui/crumbs/hobeventhandler: move remaining getVariable calls to init
      ui/crumbs/hobeventhandler: fix variable name typo
      hob: fix building with current selections after reparse
      hob: store recipe path at load time
      hob: fix backtrace when dismissing open dialog
      fetch2: improve usability of checksums
      fetch2: enable checksum definition as SRC_URI parameter
      doc: update manual for checksum changes

Julian Pidancet (1):
      Fix mercurial fetcher in fetch2

Kevin Tian (1):
      siggen.py: better print for task hash comparison

Khem Raj (1):
      fetch, fetch2: Get rid of DeprecationWarning notice

Lianhao Lu (3):
      Add PR service deamon to bitbake
      ui/hob: Fixed the "build again" hang.
      bitbake cooker/ui: handle cmd line parsing result by individual UI.

Liping Ke (6):
      cache.py: Refactory Current Cache implementation
      cache: Introduce extra cache class for image creator
      cache: Introduce new param caches_array into Cache impl.
      cache: Implement multiple extra cache fields request support
      bitbake: Make bitbake server type configurable.
      Remove unused target tree data for Hob

Mark Hatle (4):
      fetch2: unpack revision
      runqueue.py: Enable PSEUDO (fakeroot) before the fork
      build.py: Merge fakeroot changes from Poky
      runqueue.py: Add umask task control

Martin Jansa (4):
      setup.py: also install bitbake-{layers,diffsigs} scripts
      setup.py: install fetch2 module
      fetch2/git: fix logger.debug
      fetch2/git: be more carefull in _contains_ref when checking git log output

Matthew McClintock (2):
      fetch2/git: Make git fetch run with -f so rebased branches don't fail
      fetch2: Export additional variables to the fetchers

Otavio Salvador (2):
      codeparser.py: fix syntax error in exception handling
      codeparser.py: fix syntax error in exception handling

Paul Eggleton (31):
      bitbake: use layer priority when applying bbappends
      bitbake/runqueue: fix clash when setscene & real tasks done in same build
      bitbake/runqueue: show correct task name for setscene task failure
      track skipped packages
      bitbake-layers: handle skipped recipes
      bitbake: track 'overlayed' recipes
      bitbake-layers: add show_overlayed action
      bitbake/cooker: implement layer dependencies, make priority optional
      bitbake-layers: add command to flatten layers into one
      bitbake-layers: fix sorting of show_appends output
      bitbake-layers: fix sorting by package name for cooker change
      bitbake-layers: fix error on startup caused by recent cooker change
      bitbake/ast: include class name when arguments given in variant
      bitbake/cache: allow class names with arguments to be specified
      add note to -b option indicating no dependency handling
      bitbake/cooker: show a warning when -b is specified
      adjust comments/messages for default server change
      bitbake-layers: check for errors before parsing
      bitbake-layers: add command help
      bitbake-layers: remove unneeded do_EOF
      bitbake: show more information for NoProvider errors
      bitbake/taskdata: fix incorrect usage of rdependees instead of dependees
      bitbake/providers: list PREFERRED_VERSION candidates when unavailable
      bitbake-layers: improve default command help
      bitbake-layers: show help with no command specified
      bitbake-layers: use logger.plain instead of info
      bitbake-layers: extend show_layers
      hob: clear out temporary file list after deleting
      hob: fix segfault on second build
      fetch2/git: fix subpath destination directory
      bitbake/lib/bb/msg.py: fix setting debug and verbosity levels

Richard Purdie (112):
      Increment version for development version
      bitbake/siggen.py: Fix whitelisted variable handling
      bitbake/build.py: Rename message field to avoid DeprecationWarning: BaseException.message warning
      bitbake/utils.py: Add option of holding shared lockfiles
      bitbake/utils.py: Teach unlockfile about shared mode lockfiles
      bitbake/providers.py: Fix runtime providers problems
      bitbake/utils: Ignore OSError in unlockfile
      bitbake/unlockfile: Fix exception handling
      bitbake/build.py: When looking up extra stamp info for setscene tasks, use the real taskname
      process.py: Avoid deprecation warning
      bitbake/fetch2: Fix message about md5 checksums when sha256 is incorrect
      bitbake/fetch2: Pass over malformatted (empty) mirror url lines
      bitbake/fetch2: Correctly handle git mirror tarball fetching
      bitbake/fetch2: Ensure failed fetch attempts are logged in the debug logs
      bitbake/fetch2/wget: Fix missing string parameter reference
      bitbake/fetch2: Ensure network access status is reset for each loop iteration in download()
      bitbake/fetch2: Add some debug output so its clear when PREMIRRORS, upstream and MIRRORS are being used
      bitbake/fetch2: Fix patch merge error
      bitbake/fetch2: Add explict network access exception and handling to give users usable error messages
      bitbake/fetch2: Revert part of the unpack change until the issues with it are resolved
      bitbake/fecth2: Ensure BB_FETCH_PREMIRRORONLY being set as false is handled correctly
      bitbake/cooker: Fix parsing failure zombie problem
      bitbake/fetch2: Ensure SRCREV_pn-PN is checked for a revision when the SRC_URI is unnamed
      bitbake/data_smart: Improve the way lazyassignment works
      bitbake/data_smart: Improve Variable expansion error handling
      build.py: Improve exec_task standalone usage
      build.py: Operate logfile handling at the task level
      bitbake/utils.py: Allow join_deps to return a list that isn't comman separated
      bitbake/ast.py: Only run finalise() for the specified variant
      bitbake/cooker/codeparser: Ensure the code parser cache is saved for each parsing process
      bitbake/cache.py: Ensure skipped recipes make it into the cache to avoid reparsing
      bitbake/codeparser: Correctly handle a missing/empty cache file
      build.py: Fix ordering bug introduced in 7a29ab534388c0095f7f826b16c5cff343927d10
      bitbake/fetch2/git: Fix a bug where AUTOREV and the git fetcher interact badly
      bitbake/fetch2: Fix the problems introduced by the git fetcher AUTOREV fix
      bitbake/fetch2: Allow local file:// urls to be found on mirrors
      bitbake/fetch2/local: Fix inverted update required logic
      bitbake/utils.py: Only try and add read access to a file if we don't have it
      codeparser.py: Ignore incomplete cache files
      codeparser.py: Ignore incomplete cache files
      build/siggen: Ensure a task signature file is generated for each task that is executed
      cooker.py: Don't show spurious warnings for collections of .bbappend files
      bitbake/cooker.py: Fix -b option regexp handling
      bitbake/cooker.py: Ensure BBFILES is processed in order
      bitbake/utils.py: Add option to lockfiles to return immediately rather than wait
      bitbake/runqueue.py: Ensure existing setscene stamp files are taken into account
      runqueue.py: Set BB_WORKERCONTEXT in task execution context
      bitbake/codeparser: Improve cache handling
      providers.py: Correct PREFERRED_VERSION handling
      data_smart: Adding overrides of zero length is pointless so lets not
      cache.py: Sync what amounts to whitespace with bitbake in poky, pending merge of cache patches
      cooker/process.py: Move profiling code to a place it can be reused by different server mechanisms
      bitbake/runqueue: When we successfully fork off a task and there are more processes we can start do so immediately
      bitbake/runqueue: When we have successfully collected a pid value return True to ensure we don't sleep in the main loop
      bitbake/cooker: Ensure delays are accurately transfered to the idle loops from runqueue
      bitbake/cooker.py: Fix debug message arguments
      bitbake/server/process: Move implementation knowledge of event queue into the server
      bitbake/server: Move server specific code into the server backend and create a server API
      bitbake/server: Add the none server back for now
      xmlrpc/event: Add ability to send pickled events to UI if requested
      hob/crumbs/hobeventhandler: Remove server specific implementation details missed in the precious cleanup
      knotty: If any error messages are seen, set our exit code accordingly
      data.py: Ensure vardeps flags get expanded
      runqueue.py: Export further hash information into the task environment
      bitbake-layers: Add comment header
      build/runqueue: Pass quieterrors flag around to supress errors at task execution time
      cooker.py: Drop duplicate parseCommandLine call
      Drop psyco support
      persist_data: Add back code to retry in the case of locked database errors
      bitbake/data_smart: Change overrides behaviour to remove expanded variables from the datastore
      bitbake/parse/ast: We always need to finalize the default data since otherwise overrides to BBCLASSEXTEND may not be applied
      bitbake/event/ast: Add RecipePreFinalise event
      Update version to 1.13.1
      bitbake/cooker: Fix -b option by ensuring the empty cache structure is present
      bitbake/fetch2: When replacing URLs in mirror handling mask out empty entries
      codeparser: When loading the cache, ignore ValueError
      process.py: Fix issue where early errors weren't making it to the console
      bitbake/data_smart: Optimise the data store iterator
      bitbake/data_smart: Don't export deleted/empty entries in the list of keys
      bitbake/data_smart: Don't track overrides in deleted variable names
      bitbake/ast: Call expandkeys after the RecipePreFinalise event
      bitbake/ast: Add optional argument for BBCLASSEXTEND
      Update version to 1.13.2
      bitbake/ast: Fix ??= vs. ?= handling
      ui/depexp: If we're parsing zero files we need to ensure the cache progress bar gets hidden
      cache.py: Ensure additional .bbappend files are accounted for
      bitbake/process.py: Ensure queued UI events are queued right before we add our own handler
      fetch2/git: Tweak git fetcher to handling repo updates correctly
      parse/ConfHandler: Fix multiline variable corruption
      Merge remote-tracking branch 'origin/master'
      bitbake/utils: Add contains helper function from lib.oe.utils
      Update version to 1.13.3
      bitbake/utils: 'Fix' bb.utils.contains() behaviour
      bitbake/ui/knotty: Ensure 'No Provider' errors set an exit code
      bitbake/ui/knotty: Ensure previous failures aren't masked by a final successful command
      bitbake: Fix -e when used with -b option
      bitbake/usermanual: Update to be more in sync with bitbake codebase
      bitbake/logging: Overhaul internal logging process
      bitbake/msg.py: Drop manually created domain lists
      build.py: Fix cut and paste error
      Fixup remaining bb.msg.domain users
      fetch2/git: Add rsync as a valid git protocol
      usermanual: The git fetcher defaults to the git protocol (or file)
      bitbake: Correctly handle multiline comments including whitespace
      bitbake/fetch2/git: Ensure .gitconfig file is ignored
      bitbake/event: Allow event handlers to quietly raise SkipPackage events
      runqueue: Ensure task environment is correct
      runqueue.py: Ensure fakeroot variables are reflected in the datastore
      git.py: Fix logging vs logger typo
      cooker.py: Fix key expansion issues in showVersions
      Merge branch 'master' of git.openembedded.org:bitbake
      Release 1.14.0

Robert Yang (1):
      bitbake: Add task specific stamp file support

Saul Wold (1):
      universe target: add a new target to collect all recipe targets

Scott Garman (3):
      cache.py: fix bitbake -s command
      make exception handling syntax consistent
      fetch2/git.py: improve error reporting when an invalid protocol is used

Yu Ke (8):
      git fetcher: make tag back to work, fix Yocto bug 972
      git fetcher: add support for rebaseable git repo
      fetch2/git: change default protocol from rsync to git
      fetch2/git: unify the nocheckout option format
      fetch2/git: add document for git fetcher supported options
      fetch2/git: enhance the unpack by using "git checkout"
      fetcher2: retry mirror if upstream checksum mismatch
      fetcher2: show warning message when checksum is mismatch




