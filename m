Received: from mail-gy0-f175.google.com ([209.85.160.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <george.huntingtoniii@gmail.com>)
	id 1RMKV6-00017i-UR; Fri, 04 Nov 2011 15:12:09 +0100
Received: by gyh4 with SMTP id 4so1209112gyh.6
	for <multiple recipients>; Fri, 04 Nov 2011 07:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=Z7iIbKk/+Y1hk+EdJj4he8zYLp7tLxX6TwcqeiaBgmw=;
	b=cyV60wrtB+mnr6yLztJkwwcGOr8/bgip0LJW812fJEg4yjzRjKwDspJ+Ki8/AOoiWp
	rbXU0/B+MyU4eqH2GA1mFdWji6EXe0KGbIo5yScYgGwPJwtx93CbBK+Xp/eBeCbQ6vxS
	72DQRUydtrmd7hV6u3/Y6Ch2OwwbKKyXL22yw=
MIME-Version: 1.0
Received: by 10.150.164.2 with SMTP id m2mr15104683ybe.79.1320415557780; Fri,
	04 Nov 2011 07:05:57 -0700 (PDT)
Received: by 10.150.98.12 with HTTP; Fri, 4 Nov 2011 07:05:57 -0700 (PDT)
In-Reply-To: <1320361692.20107.103.camel@ted>
References: <1320361692.20107.103.camel@ted>
Date: Fri, 4 Nov 2011 10:05:57 -0400
Message-ID: <CAFu+nvG9gLNyCOEcE9ZdCwCe8wtzn=4vxdd3fGz2mP_zBtAM_Q@mail.gmail.com>
From: "George C. Huntington, III" <george.huntingtoniii@gmail.com>
To: Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
X-Mailman-Approved-At: Tue, 08 Nov 2011 15:02:28 +0100
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [OE-core] Bitbake 1.14.0 released!
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
X-List-Received-Date: Fri, 04 Nov 2011 14:12:09 -0000
Content-Type: multipart/alternative; boundary=0015175117f247058204b0e9343f

--0015175117f247058204b0e9343f
Content-Type: text/plain; charset=UTF-8

can the new bitbake be used on oe-classic, 2011.03-maintenance branch?


On Thu, Nov 3, 2011 at 7:08 PM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> Bitbake 1.14.0 has been released.
>
> http://downloads.yoctoproject.org/releases/bitbake/bitbake-1.14.0.tar.gz
>
> [I've placed the bitbake tarballs onto Yocto infrastructure until OE
> infrastructure gets sorted out. Berlios goes away in 7 weeks so I wanted
> a backup of them somewhere and I didn't want to hold the release any
> further]
>
> This release contains many bugfixes and improvements over 1.12 and
> includes hob, a graphical interface to running builds and image
> construction. A git log of the differences between 1.12 and 1.14
> follows.
>
> Bernhard Reutner-Fischer (1):
>      manual: fix typo
>
> Brandon Stafford (1):
>      doc/usermanual.xml: Tweaks for the manual
>
> Chris Larson (50):
>      cooker: simplify self.configuration.data vs data usage
>      cooker: use BBHandler.inherit for INHERIT
>      build: switch to old cwd handling
>      build: add missing newline
>      bitbake-layers: drop 2.6 from #!, per Joshua Lock
>      server: use local fixed _bootstrap when appropriate
>      goggle: exit quietly on ^C
>      hob: adjust for master's eventHandler API
>      lockfile: ask for forgiveness, not permission
>      utils: fix typo in lockfile
>      bb.siggen: import os
>      codeparser: fix ShellSyntaxError usage
>      codeparser: use ==, not 'is' to compare strings
>      Fix more incorrect usages of 'is'
>      More 'is' fixups
>      Initial work on getting bitbake working under pypy
>      build: add missing bit necessary for mhatle's fakeroot fix
>      runqueue: simplify fakeroot environment handling
>      build: in exec_func, mkdirhier ${T}
>      build: fix dir removal traceback
>      build: don't choke if olddir no longer exists
>      event: register event handler functions, not code objects
>      event: improve output when eventhandler exec fails
>      event: improve output for syntax errors in handlers
>      cooker: fix -b with BBCLASSEXTEND
>      persist_data: raise KeyError on missing elements
>      persist_data: add has_key
>      persist_data: don't allow non-string keys/values
>      persist_data: make SQLTable a context manager
>      persist_data: implement comparison, same as dict
>      build: run fakeroot if FAKEROOT is set
>      bb.namedtuple_with_abc: add useful util from activestate
>      bb.exceptions: add code to create pickleable traceback entries
>      bb.exceptions: add to_string convenience function
>      bb.exceptions: handle tb entries without context
>      bb.exceptions: don't show a repr of 'self'
>      cooker: show a useful message for ParsingFailure
>      cooker: pass traceback back from parsing thread
>      cooker: use logger.exception for config file parse errors
>      cooker: don't show a useless traceback for SyntaxError
>      cooker: don't show a traceback for ParseError
>      Shift exception formatting into the UI
>      Merge remote branch 'github/exceptions'
>      event: don't catch systemexit from handler execution
>      cooker: handle ExpansionError the same way we do ParseError
>      parse: pass a useful (if mangled) key to bb.data.expand for :=
>      siggen: don't choke with traceback when data is None
>      bb.exceptions: don't choke on frames without arguments
>      Revert the unintentionally pushed msg.py change
>      event: fix the event display order when exiting early
>
> Christopher Larson (6):
>      fetch.git: fix a remnant wrt persist + keyerror
>      msg: use a simpler enumeration for the domains
>      msg: fix domain enum use
>      cache: fix remnant broken 'info' reference from recent cache changes
>      taskdata: fix string formatting of an error message
>      codeparser: make var_expands actually hold useful information
>
> Cliff Brake (1):
>      Linefeed to test commits
>
> Darren Hart (4):
>      correct typo in ??= documentation
>      bitbake docs: use dblatex to build the pdf bitbake manual
>      fetch2/git: use logging.debug() and clarify messages
>      fetch2/git: ensure network check log matches actual command
>
> Denys Dmytriyenko (1):
>      lib/bb/providers: make "checking PREFERRED_PROVIDER_%s" a debug
> message
>
> Dexuan Cui (1):
>      bitbake/cooker, bitbake-layers: show the .bbappend files that matches
> no existing .bb recipe
>
> Dmitry Eremin-Solenikov (1):
>      lib/bb/siggen.py: return a string from noop get_taskhash
>
> Dongxiao Xu (3):
>      Introduce stamp-extra-info task flag into stamp filenames
>      fix parameter order for flaglist()
>      data_smart.py: make use of expand cache in getVar()
>
> Holger Hans Peter Freyther (1):
>      fetch2/git: Allow to specify the name of the checkout directory
>
> Jessica Zhang (3):
>      ui/crumbs/tasklistmodel: fix loading a saved recipe
>      ui/crumbs/hobprefs: trigger reparse when package format changed
>      bb/ui/hob: Restore toolchain relevant preference settings for build
>
> Joshua Lock (155):
>      bitbake/cache: store a list of inherited files in the cache
>      implement command to get all possible targets and their dependencies
>      implement command to find configuration files for a config variable
>      bitbake/cooker: add generateTargetsTree method
>      bitbake/cooker: reduce code duplication
>      bitbake/[cooker|cache]: cache summary, license and group. Add to
> targets tree
>      introduce crumbs.TaskListModel a gtk.ListStore subclass
>      bitbake/event: fix some whitespace issues
>      bitbake/crumbs: update documentation header
>      bitbake/progress: add method to pulse the progress bar
>      bitbake/cooker: don't drop possible_world ref count
>      Add new UI hob, a prototype Gtk+ GUI for creating images
>      bitbake/progress: make progress dialog modal for parent window
>      bitbake/cache: bump cache version after recent changes
>      bitbake/ui: Fix Gtk+ GUI's after recent cache changes
>      uievent: fix queueing of events for xmlrpc before UI has loaded
>      server: add updated/fixed xmlrpc server from Poky
>      bitbake/cooker: don't error in prepareTreeData for unbuildable targets
>      bitbake/hob: only show one progress dialog when changing machine
>      bitbake/depexp: closing progress dialog kills gui
>      bitbake/goggle: closing the progress dialog kills the UI
>      bitbake/hob: fix cancel button
>      command|cooker: allow generating targets tree for specified pkgs
>      cooker: add generic method to locate configuration files
>      command|cooker|event: add findConfigFilePath command
>      cooker|command|event: add new command findFilesMatchingInDir
>      cooker: remove code duplication in non trivial functions
>      cooker: switch to new universe target rather than world
>      bitbake: add -R option for loading configuration files after
> bitbake.conf
>      hob: re-designed interaction and implementation
>      ui/crumbs/tasklistmodel: fix reset method
>      lib/bb/hob: fix changing base image
>      lib/bb/ui/hob: don't error when dismissing save as dialog
>      ui/crumbs/tasklistmodel: update brought in by column when possible
>      ui/crumbs/tasklistmodel: fix automatic removal of orphaned items
>      cooker: only return *Found events if something was actually found
>      ui/crumbs/hobprefs: add missing import
>      ui/crumbs/tasklistmodel: fix saving recipes
>      ui/hob: add more guidance to the stop dialog
>      ui/crumbs/configurator: write new lines after new entries
>      ui/hob: don't crash if PARALLEL_MAKE doesn't include a space
>      ui/crumbs/tasklistmodel: ignore tasks and images when marking
> dependencies
>      hob: refer to tasks as Package Collections
>      ui/crumbs/tasklistmodel: don't show native and cross recipes
>      ui/hob: clear the search entry when resetting
>      ui/hob: if the user clicks Stop a second time only offer 'Force Stop'
>      hob: only add new layer's to the UI
>      ui/crumbs/hobprefs: set higher arbitrary limit on threads &
> parallelism
>      ui/crumbs/hobprefs: tweak the package format tooltip
>      hob: rework image output type setting
>      bitbake|cooker: save a copy of the environment when BitBake is started
>      data|cooker: use saved environment variables when calling
> inheritFromOS
>      bitbake-layers: adapt to cooker change for saved environment
>      command|cooker: Add reparseFiles command
>      cooker: only append files once
>      ui/hob: replace the ugly static command map
>      ui/crumbs/hobeventhandler: reparse files before running other commands
>      ui/hob: switch from buildFile to buildTargets for custom image builds
>      ui/hob: don't offer to show built output if build fails
>      ui/hob: change wording in build complete dialog
>      ui/hob: Force the 'Base image combo' to be drawn correctly
>      ui/hob: enable building an image with minimal contents
>      ui/crumbs/tasklistmodel: handle items added in by base image being
> removed
>      ui/crumbs/tasklistmodel: don't iterate whole model in
> find_alt_dependency()
>      ui/crumbs/tasklistmodel: work around overly aggressive package removal
>      hob: fix loading customised image recipe
>      cooker: populate rdepends-pkg in generatePkgDepTreeData
>      hob: more reliable disabling of GPLv3 packages
>      hob: fix save/restore of toolchain preferences
>      ui/crumbs/hobeventhandler: remove unused code
>      hob: unset busy cursor on exit
>      ui/crumbs/hobeventhandler: emit a signal when there's a fatal-error
>      ui/hob: show error and exit if we receive the fatal-error signal
>      ui/crumbs/hobeventhandler: emit a signal when a command fails
>      ui/crumbs/configurator: tweak addLayerConf return values
>      ui/crumbs/layereditor: if layer adding fails show an explanatory
> dialog
>      hob: remove temporary directory on program shutdown
>      bb/ui/hob: save changes to bblayers.conf when using Add Layer menu
> item
>      bb/ui/crumbs/runningbuild: optionally create list entries sequentially
>      bb/ui/hob: show build messages are displayed in the order they're
> received
>      ui/crumbs/runningbuild: add optional readonly mode, default off
>      bb/ui/hob: disable editing in the build messages tree view
>      bb/ui/crumbs/runningbuild: emit signal when command fails with exit
> signal
>      bb/ui/hob: fix detection of whether GPLv3 is disabled
>      bb/ui/crumbs/tasklistmodel: fix regex used for loading image recipes
>      bb/ui/hob: prevent label on progress bar from changing rapidly when
> loading
>      bb/ui/crumbs/hobeventhandler: use generic loading message once cache
> loaded
>      bb/ui/hob: only connect to the changed signal of image_combo once
>      bb/ui/hob: be clear that the image contents are an estimate
>      bb/ui/hob: reset event handler once build complete
>      bb/cooker: mark parsed conf files as potential cache invalidators
>      bb/ui/crumbs/tasklistmodel: prevent hang when removing item
>      bb/ui/hob: move some code around to avert a race
>      bb/cooker: only emit ConfigFilePathFound for files which were parsed
>      bb/ui/crumbs/tasklistmodel: fix some typos and add comments to mark()
>      bb/ui/crumbs/tasklistmodel: correctly uniquify dependency list
>      bb/ui/crumbs/tasklistmodel: don't include an item in its own depends
>      bb/cache: rename confusing variable
>      bb/command|cooker: refactor the reparseFiles logic
>      bb/ui/crumbs/hobeventhandler: adapt to reset -> reparse change
>      bb/ui/crumbs/configurator: introduce writeConfFile method for all
> writes
>      lib/bb/ui/crumbs/hobprefs: fix erroneous save/reparse
>      bb/crumbs/tasklistmodel: filter nativesdk packages out of views
>      bb/ui/crumbs/tasklistmodel: include package level information
>      bb/ui/crumbs/tasklistmodel: optimise find_path_for_item
>      bb/ui/crumbs/tasklistmodel: make package_model_filter a little safer
>      bb/ui/crumbs/tasklistmodel: simplify conditional in include_item
>      Ensure only the filtered environment variables are inherited from the
> OS
>      bb/ui/crumbs/runningbuild: reduce number of messages after recent msg
> change
>      bb/ui/crumbs/runningbuild: hide the progress bar on cache load
> complete
>      bb/ui/crumbs/tasklistmodel: more robust checking for substrings
>      bb/ui/crumbs/tasklistmodel: remove useless items from dependency list
>      bb/ui/crumbs/tasklistmodel: store all binb, not just the first
>      hob: don't try and build if user selects Bake with no selections made
>      bb/ui/crumbs/tasklistmodel: track the PN for each entry in the model
>      bb/ui/hob: fix package only build
>      bb/ui/crumbs/hobeventhandler: fix return values of *_image_output_type
>      bb/ui/crumbs/hobprefs: fix setting IMAGE_FSYTPES
>      bb/ui/hob: warn and prevent image build if no IMAGE_FSTYPE is set
>      bb/fetch2/git: add checkstatus command
>      hob: don't set PARALLEL_MAKE and BB_NUMBER_THREADS based on cpu count
>      bb/ui/crumbs/tasklistmodel: fix find_reverse_depends method
>      hob: disable some menu entries whilst build is in progress
>      ui/crumbs/tasklistmodel: don't add same item to binb column more than
> once
>      ui/crumbs/runningbuild: add a 'Copy' item to the messages right-click
> menu
>      ui/crumbs/tasklistmodel: don't add same item to binb column more than
> once
>      ui/crumbs/tasklistmodel: prevent packages depending on each other
>      ui/crumbs/tasklistmodel: optimise find_path_for_item()
>      ui/crumbs/tasklistmodel: remove unnecessary check
>      ui/crumbs/tasklistmodel: loop optimisation in include_item()
>      ui/crumbs/tasklistmodel: don't add empty entries to COL_BINB
>      hob: use both pre and post files for hob configuration
>      hob: reflect defaultsetup being default distro
>      hob: add a test to ensure hob is run with the required pre and post
> files
>      ui/crumbs/hobprefs: disable 'build toolchain with headers'
>      ui/crumbs/runningbuild: mask run_buildstats failure
>      hob: disable removal of packages
>      ui/crumbs/hobeventhandler: fix test for BBFILES
>      ui/crumbs/hobeventhandler: don't check BBPATH and BBFILES each build
>      hob: correctly handle an exception
>      hob: correctly set the selected image when loading a recipe
>      fetch2/wget: make checkstatus() quieter
>      ui/crumbs/hobprefs: re-enable reloading of data after prefs changes
>      hob: fix build again when building packages only
>      hob: enable package only builds even if an image has been built
>      ui/crumbs/runningbuild: fix log messages right-click menu
>      hob: fix opening of image output dir on image build completion
>      ui/crumbs/hobeventhandler: move remaining getVariable calls to init
>      ui/crumbs/hobeventhandler: fix variable name typo
>      hob: fix building with current selections after reparse
>      hob: store recipe path at load time
>      hob: fix backtrace when dismissing open dialog
>      fetch2: improve usability of checksums
>      fetch2: enable checksum definition as SRC_URI parameter
>      doc: update manual for checksum changes
>
> Julian Pidancet (1):
>      Fix mercurial fetcher in fetch2
>
> Kevin Tian (1):
>      siggen.py: better print for task hash comparison
>
> Khem Raj (1):
>      fetch, fetch2: Get rid of DeprecationWarning notice
>
> Lianhao Lu (3):
>      Add PR service deamon to bitbake
>      ui/hob: Fixed the "build again" hang.
>      bitbake cooker/ui: handle cmd line parsing result by individual UI.
>
> Liping Ke (6):
>      cache.py: Refactory Current Cache implementation
>      cache: Introduce extra cache class for image creator
>      cache: Introduce new param caches_array into Cache impl.
>      cache: Implement multiple extra cache fields request support
>      bitbake: Make bitbake server type configurable.
>      Remove unused target tree data for Hob
>
> Mark Hatle (4):
>      fetch2: unpack revision
>      runqueue.py: Enable PSEUDO (fakeroot) before the fork
>      build.py: Merge fakeroot changes from Poky
>      runqueue.py: Add umask task control
>
> Martin Jansa (4):
>      setup.py: also install bitbake-{layers,diffsigs} scripts
>      setup.py: install fetch2 module
>      fetch2/git: fix logger.debug
>      fetch2/git: be more carefull in _contains_ref when checking git log
> output
>
> Matthew McClintock (2):
>      fetch2/git: Make git fetch run with -f so rebased branches don't fail
>      fetch2: Export additional variables to the fetchers
>
> Otavio Salvador (2):
>      codeparser.py: fix syntax error in exception handling
>      codeparser.py: fix syntax error in exception handling
>
> Paul Eggleton (31):
>      bitbake: use layer priority when applying bbappends
>      bitbake/runqueue: fix clash when setscene & real tasks done in same
> build
>      bitbake/runqueue: show correct task name for setscene task failure
>      track skipped packages
>      bitbake-layers: handle skipped recipes
>      bitbake: track 'overlayed' recipes
>      bitbake-layers: add show_overlayed action
>      bitbake/cooker: implement layer dependencies, make priority optional
>      bitbake-layers: add command to flatten layers into one
>      bitbake-layers: fix sorting of show_appends output
>      bitbake-layers: fix sorting by package name for cooker change
>      bitbake-layers: fix error on startup caused by recent cooker change
>      bitbake/ast: include class name when arguments given in variant
>      bitbake/cache: allow class names with arguments to be specified
>      add note to -b option indicating no dependency handling
>      bitbake/cooker: show a warning when -b is specified
>      adjust comments/messages for default server change
>      bitbake-layers: check for errors before parsing
>      bitbake-layers: add command help
>      bitbake-layers: remove unneeded do_EOF
>      bitbake: show more information for NoProvider errors
>      bitbake/taskdata: fix incorrect usage of rdependees instead of
> dependees
>      bitbake/providers: list PREFERRED_VERSION candidates when unavailable
>      bitbake-layers: improve default command help
>      bitbake-layers: show help with no command specified
>      bitbake-layers: use logger.plain instead of info
>      bitbake-layers: extend show_layers
>      hob: clear out temporary file list after deleting
>      hob: fix segfault on second build
>      fetch2/git: fix subpath destination directory
>      bitbake/lib/bb/msg.py: fix setting debug and verbosity levels
>
> Richard Purdie (112):
>      Increment version for development version
>      bitbake/siggen.py: Fix whitelisted variable handling
>      bitbake/build.py: Rename message field to avoid DeprecationWarning:
> BaseException.message warning
>      bitbake/utils.py: Add option of holding shared lockfiles
>      bitbake/utils.py: Teach unlockfile about shared mode lockfiles
>      bitbake/providers.py: Fix runtime providers problems
>      bitbake/utils: Ignore OSError in unlockfile
>      bitbake/unlockfile: Fix exception handling
>      bitbake/build.py: When looking up extra stamp info for setscene
> tasks, use the real taskname
>      process.py: Avoid deprecation warning
>      bitbake/fetch2: Fix message about md5 checksums when sha256 is
> incorrect
>      bitbake/fetch2: Pass over malformatted (empty) mirror url lines
>      bitbake/fetch2: Correctly handle git mirror tarball fetching
>      bitbake/fetch2: Ensure failed fetch attempts are logged in the debug
> logs
>      bitbake/fetch2/wget: Fix missing string parameter reference
>      bitbake/fetch2: Ensure network access status is reset for each loop
> iteration in download()
>      bitbake/fetch2: Add some debug output so its clear when PREMIRRORS,
> upstream and MIRRORS are being used
>      bitbake/fetch2: Fix patch merge error
>      bitbake/fetch2: Add explict network access exception and handling to
> give users usable error messages
>      bitbake/fetch2: Revert part of the unpack change until the issues
> with it are resolved
>      bitbake/fecth2: Ensure BB_FETCH_PREMIRRORONLY being set as false is
> handled correctly
>      bitbake/cooker: Fix parsing failure zombie problem
>      bitbake/fetch2: Ensure SRCREV_pn-PN is checked for a revision when
> the SRC_URI is unnamed
>      bitbake/data_smart: Improve the way lazyassignment works
>      bitbake/data_smart: Improve Variable expansion error handling
>      build.py: Improve exec_task standalone usage
>      build.py: Operate logfile handling at the task level
>      bitbake/utils.py: Allow join_deps to return a list that isn't comman
> separated
>      bitbake/ast.py: Only run finalise() for the specified variant
>      bitbake/cooker/codeparser: Ensure the code parser cache is saved for
> each parsing process
>      bitbake/cache.py: Ensure skipped recipes make it into the cache to
> avoid reparsing
>      bitbake/codeparser: Correctly handle a missing/empty cache file
>      build.py: Fix ordering bug introduced in
> 7a29ab534388c0095f7f826b16c5cff343927d10
>      bitbake/fetch2/git: Fix a bug where AUTOREV and the git fetcher
> interact badly
>      bitbake/fetch2: Fix the problems introduced by the git fetcher
> AUTOREV fix
>      bitbake/fetch2: Allow local file:// urls to be found on mirrors
>      bitbake/fetch2/local: Fix inverted update required logic
>      bitbake/utils.py: Only try and add read access to a file if we don't
> have it
>      codeparser.py: Ignore incomplete cache files
>      codeparser.py: Ignore incomplete cache files
>      build/siggen: Ensure a task signature file is generated for each task
> that is executed
>      cooker.py: Don't show spurious warnings for collections of .bbappend
> files
>      bitbake/cooker.py: Fix -b option regexp handling
>      bitbake/cooker.py: Ensure BBFILES is processed in order
>      bitbake/utils.py: Add option to lockfiles to return immediately
> rather than wait
>      bitbake/runqueue.py: Ensure existing setscene stamp files are taken
> into account
>      runqueue.py: Set BB_WORKERCONTEXT in task execution context
>      bitbake/codeparser: Improve cache handling
>      providers.py: Correct PREFERRED_VERSION handling
>      data_smart: Adding overrides of zero length is pointless so lets not
>      cache.py: Sync what amounts to whitespace with bitbake in poky,
> pending merge of cache patches
>      cooker/process.py: Move profiling code to a place it can be reused by
> different server mechanisms
>      bitbake/runqueue: When we successfully fork off a task and there are
> more processes we can start do so immediately
>      bitbake/runqueue: When we have successfully collected a pid value
> return True to ensure we don't sleep in the main loop
>      bitbake/cooker: Ensure delays are accurately transfered to the idle
> loops from runqueue
>      bitbake/cooker.py: Fix debug message arguments
>      bitbake/server/process: Move implementation knowledge of event queue
> into the server
>      bitbake/server: Move server specific code into the server backend and
> create a server API
>      bitbake/server: Add the none server back for now
>      xmlrpc/event: Add ability to send pickled events to UI if requested
>      hob/crumbs/hobeventhandler: Remove server specific implementation
> details missed in the precious cleanup
>      knotty: If any error messages are seen, set our exit code accordingly
>      data.py: Ensure vardeps flags get expanded
>      runqueue.py: Export further hash information into the task environment
>      bitbake-layers: Add comment header
>      build/runqueue: Pass quieterrors flag around to supress errors at
> task execution time
>      cooker.py: Drop duplicate parseCommandLine call
>      Drop psyco support
>      persist_data: Add back code to retry in the case of locked database
> errors
>      bitbake/data_smart: Change overrides behaviour to remove expanded
> variables from the datastore
>      bitbake/parse/ast: We always need to finalize the default data since
> otherwise overrides to BBCLASSEXTEND may not be applied
>      bitbake/event/ast: Add RecipePreFinalise event
>      Update version to 1.13.1
>      bitbake/cooker: Fix -b option by ensuring the empty cache structure
> is present
>      bitbake/fetch2: When replacing URLs in mirror handling mask out empty
> entries
>      codeparser: When loading the cache, ignore ValueError
>      process.py: Fix issue where early errors weren't making it to the
> console
>      bitbake/data_smart: Optimise the data store iterator
>      bitbake/data_smart: Don't export deleted/empty entries in the list of
> keys
>      bitbake/data_smart: Don't track overrides in deleted variable names
>      bitbake/ast: Call expandkeys after the RecipePreFinalise event
>      bitbake/ast: Add optional argument for BBCLASSEXTEND
>      Update version to 1.13.2
>      bitbake/ast: Fix ??= vs. ?= handling
>      ui/depexp: If we're parsing zero files we need to ensure the cache
> progress bar gets hidden
>      cache.py: Ensure additional .bbappend files are accounted for
>      bitbake/process.py: Ensure queued UI events are queued right before
> we add our own handler
>      fetch2/git: Tweak git fetcher to handling repo updates correctly
>      parse/ConfHandler: Fix multiline variable corruption
>      Merge remote-tracking branch 'origin/master'
>      bitbake/utils: Add contains helper function from lib.oe.utils
>      Update version to 1.13.3
>      bitbake/utils: 'Fix' bb.utils.contains() behaviour
>      bitbake/ui/knotty: Ensure 'No Provider' errors set an exit code
>      bitbake/ui/knotty: Ensure previous failures aren't masked by a final
> successful command
>      bitbake: Fix -e when used with -b option
>      bitbake/usermanual: Update to be more in sync with bitbake codebase
>      bitbake/logging: Overhaul internal logging process
>      bitbake/msg.py: Drop manually created domain lists
>      build.py: Fix cut and paste error
>      Fixup remaining bb.msg.domain users
>      fetch2/git: Add rsync as a valid git protocol
>      usermanual: The git fetcher defaults to the git protocol (or file)
>      bitbake: Correctly handle multiline comments including whitespace
>      bitbake/fetch2/git: Ensure .gitconfig file is ignored
>      bitbake/event: Allow event handlers to quietly raise SkipPackage
> events
>      runqueue: Ensure task environment is correct
>      runqueue.py: Ensure fakeroot variables are reflected in the datastore
>      git.py: Fix logging vs logger typo
>      cooker.py: Fix key expansion issues in showVersions
>      Merge branch 'master' of git.openembedded.org:bitbake
>      Release 1.14.0
>
> Robert Yang (1):
>      bitbake: Add task specific stamp file support
>
> Saul Wold (1):
>      universe target: add a new target to collect all recipe targets
>
> Scott Garman (3):
>      cache.py: fix bitbake -s command
>      make exception handling syntax consistent
>      fetch2/git.py: improve error reporting when an invalid protocol is
> used
>
> Yu Ke (8):
>      git fetcher: make tag back to work, fix Yocto bug 972
>      git fetcher: add support for rebaseable git repo
>      fetch2/git: change default protocol from rsync to git
>      fetch2/git: unify the nocheckout option format
>      fetch2/git: add document for git fetcher supported options
>      fetch2/git: enhance the unpack by using "git checkout"
>      fetcher2: retry mirror if upstream checksum mismatch
>      fetcher2: show warning message when checksum is mismatch
>
>
>
> _______________________________________________
> Openembedded-core mailing list
> Openembedded-core@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/openembedded-core
>

--0015175117f247058204b0e9343f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

can the new bitbake be used on oe-classic, 2011.03-maintenance branch?<div>=
<br><br><div class=3D"gmail_quote">On Thu, Nov 3, 2011 at 7:08 PM, Richard =
Purdie <span dir=3D"ltr">&lt;<a href=3D"mailto:richard.purdie@linuxfoundati=
on.org">richard.purdie@linuxfoundation.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;">Bitbake 1.14.0 has been released.<br>
<br>
<a href=3D"http://downloads.yoctoproject.org/releases/bitbake/bitbake-1.14.=
0.tar.gz" target=3D"_blank">http://downloads.yoctoproject.org/releases/bitb=
ake/bitbake-1.14.0.tar.gz</a><br>
<br>
[I&#39;ve placed the bitbake tarballs onto Yocto infrastructure until OE<br=
>
infrastructure gets sorted out. Berlios goes away in 7 weeks so I wanted<br=
>
a backup of them somewhere and I didn&#39;t want to hold the release any<br=
>
further]<br>
<br>
This release contains many bugfixes and improvements over 1.12 and<br>
includes hob, a graphical interface to running builds and image<br>
construction. A git log of the differences between 1.12 and 1.14<br>
follows.<br>
<br>
Bernhard Reutner-Fischer (1):<br>
 =C2=A0 =C2=A0 =C2=A0manual: fix typo<br>
<br>
Brandon Stafford (1):<br>
 =C2=A0 =C2=A0 =C2=A0doc/usermanual.xml: Tweaks for the manual<br>
<br>
Chris Larson (50):<br>
 =C2=A0 =C2=A0 =C2=A0cooker: simplify self.configuration.data vs data usage=
<br>
 =C2=A0 =C2=A0 =C2=A0cooker: use BBHandler.inherit for INHERIT<br>
 =C2=A0 =C2=A0 =C2=A0build: switch to old cwd handling<br>
 =C2=A0 =C2=A0 =C2=A0build: add missing newline<br>
 =C2=A0 =C2=A0 =C2=A0bitbake-layers: drop 2.6 from #!, per Joshua Lock<br>
 =C2=A0 =C2=A0 =C2=A0server: use local fixed _bootstrap when appropriate<br=
>
 =C2=A0 =C2=A0 =C2=A0goggle: exit quietly on ^C<br>
 =C2=A0 =C2=A0 =C2=A0hob: adjust for master&#39;s eventHandler API<br>
 =C2=A0 =C2=A0 =C2=A0lockfile: ask for forgiveness, not permission<br>
 =C2=A0 =C2=A0 =C2=A0utils: fix typo in lockfile<br>
 =C2=A0 =C2=A0 =C2=A0bb.siggen: import os<br>
 =C2=A0 =C2=A0 =C2=A0codeparser: fix ShellSyntaxError usage<br>
 =C2=A0 =C2=A0 =C2=A0codeparser: use =3D=3D, not &#39;is&#39; to compare st=
rings<br>
 =C2=A0 =C2=A0 =C2=A0Fix more incorrect usages of &#39;is&#39;<br>
 =C2=A0 =C2=A0 =C2=A0More &#39;is&#39; fixups<br>
 =C2=A0 =C2=A0 =C2=A0Initial work on getting bitbake working under pypy<br>
 =C2=A0 =C2=A0 =C2=A0build: add missing bit necessary for mhatle&#39;s fake=
root fix<br>
 =C2=A0 =C2=A0 =C2=A0runqueue: simplify fakeroot environment handling<br>
 =C2=A0 =C2=A0 =C2=A0build: in exec_func, mkdirhier ${T}<br>
 =C2=A0 =C2=A0 =C2=A0build: fix dir removal traceback<br>
 =C2=A0 =C2=A0 =C2=A0build: don&#39;t choke if olddir no longer exists<br>
 =C2=A0 =C2=A0 =C2=A0event: register event handler functions, not code obje=
cts<br>
 =C2=A0 =C2=A0 =C2=A0event: improve output when eventhandler exec fails<br>
 =C2=A0 =C2=A0 =C2=A0event: improve output for syntax errors in handlers<br=
>
 =C2=A0 =C2=A0 =C2=A0cooker: fix -b with BBCLASSEXTEND<br>
 =C2=A0 =C2=A0 =C2=A0persist_data: raise KeyError on missing elements<br>
 =C2=A0 =C2=A0 =C2=A0persist_data: add has_key<br>
 =C2=A0 =C2=A0 =C2=A0persist_data: don&#39;t allow non-string keys/values<b=
r>
 =C2=A0 =C2=A0 =C2=A0persist_data: make SQLTable a context manager<br>
 =C2=A0 =C2=A0 =C2=A0persist_data: implement comparison, same as dict<br>
 =C2=A0 =C2=A0 =C2=A0build: run fakeroot if FAKEROOT is set<br>
 =C2=A0 =C2=A0 =C2=A0bb.namedtuple_with_abc: add useful util from activesta=
te<br>
 =C2=A0 =C2=A0 =C2=A0bb.exceptions: add code to create pickleable traceback=
 entries<br>
 =C2=A0 =C2=A0 =C2=A0bb.exceptions: add to_string convenience function<br>
 =C2=A0 =C2=A0 =C2=A0bb.exceptions: handle tb entries without context<br>
 =C2=A0 =C2=A0 =C2=A0bb.exceptions: don&#39;t show a repr of &#39;self&#39;=
<br>
 =C2=A0 =C2=A0 =C2=A0cooker: show a useful message for ParsingFailure<br>
 =C2=A0 =C2=A0 =C2=A0cooker: pass traceback back from parsing thread<br>
 =C2=A0 =C2=A0 =C2=A0cooker: use logger.exception for config file parse err=
ors<br>
 =C2=A0 =C2=A0 =C2=A0cooker: don&#39;t show a useless traceback for SyntaxE=
rror<br>
 =C2=A0 =C2=A0 =C2=A0cooker: don&#39;t show a traceback for ParseError<br>
 =C2=A0 =C2=A0 =C2=A0Shift exception formatting into the UI<br>
 =C2=A0 =C2=A0 =C2=A0Merge remote branch &#39;github/exceptions&#39;<br>
 =C2=A0 =C2=A0 =C2=A0event: don&#39;t catch systemexit from handler executi=
on<br>
 =C2=A0 =C2=A0 =C2=A0cooker: handle ExpansionError the same way we do Parse=
Error<br>
 =C2=A0 =C2=A0 =C2=A0parse: pass a useful (if mangled) key to bb.data.expan=
d for :=3D<br>
 =C2=A0 =C2=A0 =C2=A0siggen: don&#39;t choke with traceback when data is No=
ne<br>
 =C2=A0 =C2=A0 =C2=A0bb.exceptions: don&#39;t choke on frames without argum=
ents<br>
 =C2=A0 =C2=A0 =C2=A0Revert the unintentionally pushed msg.py change<br>
 =C2=A0 =C2=A0 =C2=A0event: fix the event display order when exiting early<=
br>
<br>
Christopher Larson (6):<br>
 =C2=A0 =C2=A0 =C2=A0fetch.git: fix a remnant wrt persist + keyerror<br>
 =C2=A0 =C2=A0 =C2=A0msg: use a simpler enumeration for the domains<br>
 =C2=A0 =C2=A0 =C2=A0msg: fix domain enum use<br>
 =C2=A0 =C2=A0 =C2=A0cache: fix remnant broken &#39;info&#39; reference fro=
m recent cache changes<br>
 =C2=A0 =C2=A0 =C2=A0taskdata: fix string formatting of an error message<br=
>
 =C2=A0 =C2=A0 =C2=A0codeparser: make var_expands actually hold useful info=
rmation<br>
<br>
Cliff Brake (1):<br>
 =C2=A0 =C2=A0 =C2=A0Linefeed to test commits<br>
<br>
Darren Hart (4):<br>
 =C2=A0 =C2=A0 =C2=A0correct typo in ??=3D documentation<br>
 =C2=A0 =C2=A0 =C2=A0bitbake docs: use dblatex to build the pdf bitbake man=
ual<br>
 =C2=A0 =C2=A0 =C2=A0fetch2/git: use logging.debug() and clarify messages<b=
r>
 =C2=A0 =C2=A0 =C2=A0fetch2/git: ensure network check log matches actual co=
mmand<br>
<br>
Denys Dmytriyenko (1):<br>
 =C2=A0 =C2=A0 =C2=A0lib/bb/providers: make &quot;checking PREFERRED_PROVID=
ER_%s&quot; a debug message<br>
<br>
Dexuan Cui (1):<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/cooker, bitbake-layers: show the .bbappend fil=
es that matches no existing .bb recipe<br>
<br>
Dmitry Eremin-Solenikov (1):<br>
 =C2=A0 =C2=A0 =C2=A0lib/bb/siggen.py: return a string from noop get_taskha=
sh<br>
<br>
Dongxiao Xu (3):<br>
 =C2=A0 =C2=A0 =C2=A0Introduce stamp-extra-info task flag into stamp filena=
mes<br>
 =C2=A0 =C2=A0 =C2=A0fix parameter order for flaglist()<br>
 =C2=A0 =C2=A0 =C2=A0data_smart.py: make use of expand cache in getVar()<br=
>
<br>
Holger Hans Peter Freyther (1):<br>
 =C2=A0 =C2=A0 =C2=A0fetch2/git: Allow to specify the name of the checkout =
directory<br>
<br>
Jessica Zhang (3):<br>
 =C2=A0 =C2=A0 =C2=A0ui/crumbs/tasklistmodel: fix loading a saved recipe<br=
>
 =C2=A0 =C2=A0 =C2=A0ui/crumbs/hobprefs: trigger reparse when package forma=
t changed<br>
 =C2=A0 =C2=A0 =C2=A0bb/ui/hob: Restore toolchain relevant preference setti=
ngs for build<br>
<br>
Joshua Lock (155):<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/cache: store a list of inherited files in the =
cache<br>
 =C2=A0 =C2=A0 =C2=A0implement command to get all possible targets and thei=
r dependencies<br>
 =C2=A0 =C2=A0 =C2=A0implement command to find configuration files for a co=
nfig variable<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/cooker: add generateTargetsTree method<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/cooker: reduce code duplication<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/[cooker|cache]: cache summary, license and gro=
up. Add to targets tree<br>
 =C2=A0 =C2=A0 =C2=A0introduce crumbs.TaskListModel a gtk.ListStore subclas=
s<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/event: fix some whitespace issues<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/crumbs: update documentation header<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/progress: add method to pulse the progress bar=
<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/cooker: don&#39;t drop possible_world ref coun=
t<br>
 =C2=A0 =C2=A0 =C2=A0Add new UI hob, a prototype Gtk+ GUI for creating imag=
es<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/progress: make progress dialog modal for paren=
t window<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/cache: bump cache version after recent changes=
<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/ui: Fix Gtk+ GUI&#39;s after recent cache chan=
ges<br>
 =C2=A0 =C2=A0 =C2=A0uievent: fix queueing of events for xmlrpc before UI h=
as loaded<br>
 =C2=A0 =C2=A0 =C2=A0server: add updated/fixed xmlrpc server from Poky<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/cooker: don&#39;t error in prepareTreeData for=
 unbuildable targets<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/hob: only show one progress dialog when changi=
ng machine<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/depexp: closing progress dialog kills gui<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/goggle: closing the progress dialog kills the =
UI<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/hob: fix cancel button<br>
 =C2=A0 =C2=A0 =C2=A0command|cooker: allow generating targets tree for spec=
ified pkgs<br>
 =C2=A0 =C2=A0 =C2=A0cooker: add generic method to locate configuration fil=
es<br>
 =C2=A0 =C2=A0 =C2=A0command|cooker|event: add findConfigFilePath command<b=
r>
 =C2=A0 =C2=A0 =C2=A0cooker|command|event: add new command findFilesMatchin=
gInDir<br>
 =C2=A0 =C2=A0 =C2=A0cooker: remove code duplication in non trivial functio=
ns<br>
 =C2=A0 =C2=A0 =C2=A0cooker: switch to new universe target rather than worl=
d<br>
 =C2=A0 =C2=A0 =C2=A0bitbake: add -R option for loading configuration files=
 after bitbake.conf<br>
 =C2=A0 =C2=A0 =C2=A0hob: re-designed interaction and implementation<br>
 =C2=A0 =C2=A0 =C2=A0ui/crumbs/tasklistmodel: fix reset method<br>
 =C2=A0 =C2=A0 =C2=A0lib/bb/hob: fix changing base image<br>
 =C2=A0 =C2=A0 =C2=A0lib/bb/ui/hob: don&#39;t error when dismissing save as=
 dialog<br>
 =C2=A0 =C2=A0 =C2=A0ui/crumbs/tasklistmodel: update brought in by column w=
hen possible<br>
 =C2=A0 =C2=A0 =C2=A0ui/crumbs/tasklistmodel: fix automatic removal of orph=
aned items<br>
 =C2=A0 =C2=A0 =C2=A0cooker: only return *Found events if something was act=
ually found<br>
 =C2=A0 =C2=A0 =C2=A0ui/crumbs/hobprefs: add missing import<br>
 =C2=A0 =C2=A0 =C2=A0ui/crumbs/tasklistmodel: fix saving recipes<br>
 =C2=A0 =C2=A0 =C2=A0ui/hob: add more guidance to the stop dialog<br>
 =C2=A0 =C2=A0 =C2=A0ui/crumbs/configurator: write new lines after new entr=
ies<br>
 =C2=A0 =C2=A0 =C2=A0ui/hob: don&#39;t crash if PARALLEL_MAKE doesn&#39;t i=
nclude a space<br>
 =C2=A0 =C2=A0 =C2=A0ui/crumbs/tasklistmodel: ignore tasks and images when =
marking dependencies<br>
 =C2=A0 =C2=A0 =C2=A0hob: refer to tasks as Package Collections<br>
 =C2=A0 =C2=A0 =C2=A0ui/crumbs/tasklistmodel: don&#39;t show native and cro=
ss recipes<br>
 =C2=A0 =C2=A0 =C2=A0ui/hob: clear the search entry when resetting<br>
 =C2=A0 =C2=A0 =C2=A0ui/hob: if the user clicks Stop a second time only off=
er &#39;Force Stop&#39;<br>
 =C2=A0 =C2=A0 =C2=A0hob: only add new layer&#39;s to the UI<br>
 =C2=A0 =C2=A0 =C2=A0ui/crumbs/hobprefs: set higher arbitrary limit on thre=
ads &amp; parallelism<br>
 =C2=A0 =C2=A0 =C2=A0ui/crumbs/hobprefs: tweak the package format tooltip<b=
r>
 =C2=A0 =C2=A0 =C2=A0hob: rework image output type setting<br>
 =C2=A0 =C2=A0 =C2=A0bitbake|cooker: save a copy of the environment when Bi=
tBake is started<br>
 =C2=A0 =C2=A0 =C2=A0data|cooker: use saved environment variables when call=
ing inheritFromOS<br>
 =C2=A0 =C2=A0 =C2=A0bitbake-layers: adapt to cooker change for saved envir=
onment<br>
 =C2=A0 =C2=A0 =C2=A0command|cooker: Add reparseFiles command<br>
 =C2=A0 =C2=A0 =C2=A0cooker: only append files once<br>
 =C2=A0 =C2=A0 =C2=A0ui/hob: replace the ugly static command map<br>
 =C2=A0 =C2=A0 =C2=A0ui/crumbs/hobeventhandler: reparse files before runnin=
g other commands<br>
 =C2=A0 =C2=A0 =C2=A0ui/hob: switch from buildFile to buildTargets for cust=
om image builds<br>
 =C2=A0 =C2=A0 =C2=A0ui/hob: don&#39;t offer to show built output if build =
fails<br>
 =C2=A0 =C2=A0 =C2=A0ui/hob: change wording in build complete dialog<br>
 =C2=A0 =C2=A0 =C2=A0ui/hob: Force the &#39;Base image combo&#39; to be dra=
wn correctly<br>
 =C2=A0 =C2=A0 =C2=A0ui/hob: enable building an image with minimal contents=
<br>
 =C2=A0 =C2=A0 =C2=A0ui/crumbs/tasklistmodel: handle items added in by base=
 image being removed<br>
 =C2=A0 =C2=A0 =C2=A0ui/crumbs/tasklistmodel: don&#39;t iterate whole model=
 in find_alt_dependency()<br>
 =C2=A0 =C2=A0 =C2=A0ui/crumbs/tasklistmodel: work around overly aggressive=
 package removal<br>
 =C2=A0 =C2=A0 =C2=A0hob: fix loading customised image recipe<br>
 =C2=A0 =C2=A0 =C2=A0cooker: populate rdepends-pkg in generatePkgDepTreeDat=
a<br>
 =C2=A0 =C2=A0 =C2=A0hob: more reliable disabling of GPLv3 packages<br>
 =C2=A0 =C2=A0 =C2=A0hob: fix save/restore of toolchain preferences<br>
 =C2=A0 =C2=A0 =C2=A0ui/crumbs/hobeventhandler: remove unused code<br>
 =C2=A0 =C2=A0 =C2=A0hob: unset busy cursor on exit<br>
 =C2=A0 =C2=A0 =C2=A0ui/crumbs/hobeventhandler: emit a signal when there&#3=
9;s a fatal-error<br>
 =C2=A0 =C2=A0 =C2=A0ui/hob: show error and exit if we receive the fatal-er=
ror signal<br>
 =C2=A0 =C2=A0 =C2=A0ui/crumbs/hobeventhandler: emit a signal when a comman=
d fails<br>
 =C2=A0 =C2=A0 =C2=A0ui/crumbs/configurator: tweak addLayerConf return valu=
es<br>
 =C2=A0 =C2=A0 =C2=A0ui/crumbs/layereditor: if layer adding fails show an e=
xplanatory dialog<br>
 =C2=A0 =C2=A0 =C2=A0hob: remove temporary directory on program shutdown<br=
>
 =C2=A0 =C2=A0 =C2=A0bb/ui/hob: save changes to bblayers.conf when using Ad=
d Layer menu item<br>
 =C2=A0 =C2=A0 =C2=A0bb/ui/crumbs/runningbuild: optionally create list entr=
ies sequentially<br>
 =C2=A0 =C2=A0 =C2=A0bb/ui/hob: show build messages are displayed in the or=
der they&#39;re received<br>
 =C2=A0 =C2=A0 =C2=A0ui/crumbs/runningbuild: add optional readonly mode, de=
fault off<br>
 =C2=A0 =C2=A0 =C2=A0bb/ui/hob: disable editing in the build messages tree =
view<br>
 =C2=A0 =C2=A0 =C2=A0bb/ui/crumbs/runningbuild: emit signal when command fa=
ils with exit signal<br>
 =C2=A0 =C2=A0 =C2=A0bb/ui/hob: fix detection of whether GPLv3 is disabled<=
br>
 =C2=A0 =C2=A0 =C2=A0bb/ui/crumbs/tasklistmodel: fix regex used for loading=
 image recipes<br>
 =C2=A0 =C2=A0 =C2=A0bb/ui/hob: prevent label on progress bar from changing=
 rapidly when loading<br>
 =C2=A0 =C2=A0 =C2=A0bb/ui/crumbs/hobeventhandler: use generic loading mess=
age once cache loaded<br>
 =C2=A0 =C2=A0 =C2=A0bb/ui/hob: only connect to the changed signal of image=
_combo once<br>
 =C2=A0 =C2=A0 =C2=A0bb/ui/hob: be clear that the image contents are an est=
imate<br>
 =C2=A0 =C2=A0 =C2=A0bb/ui/hob: reset event handler once build complete<br>
 =C2=A0 =C2=A0 =C2=A0bb/cooker: mark parsed conf files as potential cache i=
nvalidators<br>
 =C2=A0 =C2=A0 =C2=A0bb/ui/crumbs/tasklistmodel: prevent hang when removing=
 item<br>
 =C2=A0 =C2=A0 =C2=A0bb/ui/hob: move some code around to avert a race<br>
 =C2=A0 =C2=A0 =C2=A0bb/cooker: only emit ConfigFilePathFound for files whi=
ch were parsed<br>
 =C2=A0 =C2=A0 =C2=A0bb/ui/crumbs/tasklistmodel: fix some typos and add com=
ments to mark()<br>
 =C2=A0 =C2=A0 =C2=A0bb/ui/crumbs/tasklistmodel: correctly uniquify depende=
ncy list<br>
 =C2=A0 =C2=A0 =C2=A0bb/ui/crumbs/tasklistmodel: don&#39;t include an item =
in its own depends<br>
 =C2=A0 =C2=A0 =C2=A0bb/cache: rename confusing variable<br>
 =C2=A0 =C2=A0 =C2=A0bb/command|cooker: refactor the reparseFiles logic<br>
 =C2=A0 =C2=A0 =C2=A0bb/ui/crumbs/hobeventhandler: adapt to reset -&gt; rep=
arse change<br>
 =C2=A0 =C2=A0 =C2=A0bb/ui/crumbs/configurator: introduce writeConfFile met=
hod for all writes<br>
 =C2=A0 =C2=A0 =C2=A0lib/bb/ui/crumbs/hobprefs: fix erroneous save/reparse<=
br>
 =C2=A0 =C2=A0 =C2=A0bb/crumbs/tasklistmodel: filter nativesdk packages out=
 of views<br>
 =C2=A0 =C2=A0 =C2=A0bb/ui/crumbs/tasklistmodel: include package level info=
rmation<br>
 =C2=A0 =C2=A0 =C2=A0bb/ui/crumbs/tasklistmodel: optimise find_path_for_ite=
m<br>
 =C2=A0 =C2=A0 =C2=A0bb/ui/crumbs/tasklistmodel: make package_model_filter =
a little safer<br>
 =C2=A0 =C2=A0 =C2=A0bb/ui/crumbs/tasklistmodel: simplify conditional in in=
clude_item<br>
 =C2=A0 =C2=A0 =C2=A0Ensure only the filtered environment variables are inh=
erited from the OS<br>
 =C2=A0 =C2=A0 =C2=A0bb/ui/crumbs/runningbuild: reduce number of messages a=
fter recent msg change<br>
 =C2=A0 =C2=A0 =C2=A0bb/ui/crumbs/runningbuild: hide the progress bar on ca=
che load complete<br>
 =C2=A0 =C2=A0 =C2=A0bb/ui/crumbs/tasklistmodel: more robust checking for s=
ubstrings<br>
 =C2=A0 =C2=A0 =C2=A0bb/ui/crumbs/tasklistmodel: remove useless items from =
dependency list<br>
 =C2=A0 =C2=A0 =C2=A0bb/ui/crumbs/tasklistmodel: store all binb, not just t=
he first<br>
 =C2=A0 =C2=A0 =C2=A0hob: don&#39;t try and build if user selects Bake with=
 no selections made<br>
 =C2=A0 =C2=A0 =C2=A0bb/ui/crumbs/tasklistmodel: track the PN for each entr=
y in the model<br>
 =C2=A0 =C2=A0 =C2=A0bb/ui/hob: fix package only build<br>
 =C2=A0 =C2=A0 =C2=A0bb/ui/crumbs/hobeventhandler: fix return values of *_i=
mage_output_type<br>
 =C2=A0 =C2=A0 =C2=A0bb/ui/crumbs/hobprefs: fix setting IMAGE_FSYTPES<br>
 =C2=A0 =C2=A0 =C2=A0bb/ui/hob: warn and prevent image build if no IMAGE_FS=
TYPE is set<br>
 =C2=A0 =C2=A0 =C2=A0bb/fetch2/git: add checkstatus command<br>
 =C2=A0 =C2=A0 =C2=A0hob: don&#39;t set PARALLEL_MAKE and BB_NUMBER_THREADS=
 based on cpu count<br>
 =C2=A0 =C2=A0 =C2=A0bb/ui/crumbs/tasklistmodel: fix find_reverse_depends m=
ethod<br>
 =C2=A0 =C2=A0 =C2=A0hob: disable some menu entries whilst build is in prog=
ress<br>
 =C2=A0 =C2=A0 =C2=A0ui/crumbs/tasklistmodel: don&#39;t add same item to bi=
nb column more than once<br>
 =C2=A0 =C2=A0 =C2=A0ui/crumbs/runningbuild: add a &#39;Copy&#39; item to t=
he messages right-click menu<br>
 =C2=A0 =C2=A0 =C2=A0ui/crumbs/tasklistmodel: don&#39;t add same item to bi=
nb column more than once<br>
 =C2=A0 =C2=A0 =C2=A0ui/crumbs/tasklistmodel: prevent packages depending on=
 each other<br>
 =C2=A0 =C2=A0 =C2=A0ui/crumbs/tasklistmodel: optimise find_path_for_item()=
<br>
 =C2=A0 =C2=A0 =C2=A0ui/crumbs/tasklistmodel: remove unnecessary check<br>
 =C2=A0 =C2=A0 =C2=A0ui/crumbs/tasklistmodel: loop optimisation in include_=
item()<br>
 =C2=A0 =C2=A0 =C2=A0ui/crumbs/tasklistmodel: don&#39;t add empty entries t=
o COL_BINB<br>
 =C2=A0 =C2=A0 =C2=A0hob: use both pre and post files for hob configuration=
<br>
 =C2=A0 =C2=A0 =C2=A0hob: reflect defaultsetup being default distro<br>
 =C2=A0 =C2=A0 =C2=A0hob: add a test to ensure hob is run with the required=
 pre and post files<br>
 =C2=A0 =C2=A0 =C2=A0ui/crumbs/hobprefs: disable &#39;build toolchain with =
headers&#39;<br>
 =C2=A0 =C2=A0 =C2=A0ui/crumbs/runningbuild: mask run_buildstats failure<br=
>
 =C2=A0 =C2=A0 =C2=A0hob: disable removal of packages<br>
 =C2=A0 =C2=A0 =C2=A0ui/crumbs/hobeventhandler: fix test for BBFILES<br>
 =C2=A0 =C2=A0 =C2=A0ui/crumbs/hobeventhandler: don&#39;t check BBPATH and =
BBFILES each build<br>
 =C2=A0 =C2=A0 =C2=A0hob: correctly handle an exception<br>
 =C2=A0 =C2=A0 =C2=A0hob: correctly set the selected image when loading a r=
ecipe<br>
 =C2=A0 =C2=A0 =C2=A0fetch2/wget: make checkstatus() quieter<br>
 =C2=A0 =C2=A0 =C2=A0ui/crumbs/hobprefs: re-enable reloading of data after =
prefs changes<br>
 =C2=A0 =C2=A0 =C2=A0hob: fix build again when building packages only<br>
 =C2=A0 =C2=A0 =C2=A0hob: enable package only builds even if an image has b=
een built<br>
 =C2=A0 =C2=A0 =C2=A0ui/crumbs/runningbuild: fix log messages right-click m=
enu<br>
 =C2=A0 =C2=A0 =C2=A0hob: fix opening of image output dir on image build co=
mpletion<br>
 =C2=A0 =C2=A0 =C2=A0ui/crumbs/hobeventhandler: move remaining getVariable =
calls to init<br>
 =C2=A0 =C2=A0 =C2=A0ui/crumbs/hobeventhandler: fix variable name typo<br>
 =C2=A0 =C2=A0 =C2=A0hob: fix building with current selections after repars=
e<br>
 =C2=A0 =C2=A0 =C2=A0hob: store recipe path at load time<br>
 =C2=A0 =C2=A0 =C2=A0hob: fix backtrace when dismissing open dialog<br>
 =C2=A0 =C2=A0 =C2=A0fetch2: improve usability of checksums<br>
 =C2=A0 =C2=A0 =C2=A0fetch2: enable checksum definition as SRC_URI paramete=
r<br>
 =C2=A0 =C2=A0 =C2=A0doc: update manual for checksum changes<br>
<br>
Julian Pidancet (1):<br>
 =C2=A0 =C2=A0 =C2=A0Fix mercurial fetcher in fetch2<br>
<br>
Kevin Tian (1):<br>
 =C2=A0 =C2=A0 =C2=A0siggen.py: better print for task hash comparison<br>
<br>
Khem Raj (1):<br>
 =C2=A0 =C2=A0 =C2=A0fetch, fetch2: Get rid of DeprecationWarning notice<br=
>
<br>
Lianhao Lu (3):<br>
 =C2=A0 =C2=A0 =C2=A0Add PR service deamon to bitbake<br>
 =C2=A0 =C2=A0 =C2=A0ui/hob: Fixed the &quot;build again&quot; hang.<br>
 =C2=A0 =C2=A0 =C2=A0bitbake cooker/ui: handle cmd line parsing result by i=
ndividual UI.<br>
<br>
Liping Ke (6):<br>
 =C2=A0 =C2=A0 =C2=A0cache.py: Refactory Current Cache implementation<br>
 =C2=A0 =C2=A0 =C2=A0cache: Introduce extra cache class for image creator<b=
r>
 =C2=A0 =C2=A0 =C2=A0cache: Introduce new param caches_array into Cache imp=
l.<br>
 =C2=A0 =C2=A0 =C2=A0cache: Implement multiple extra cache fields request s=
upport<br>
 =C2=A0 =C2=A0 =C2=A0bitbake: Make bitbake server type configurable.<br>
 =C2=A0 =C2=A0 =C2=A0Remove unused target tree data for Hob<br>
<br>
Mark Hatle (4):<br>
 =C2=A0 =C2=A0 =C2=A0fetch2: unpack revision<br>
 =C2=A0 =C2=A0 =C2=A0runqueue.py: Enable PSEUDO (fakeroot) before the fork<=
br>
 =C2=A0 =C2=A0 =C2=A0build.py: Merge fakeroot changes from Poky<br>
 =C2=A0 =C2=A0 =C2=A0runqueue.py: Add umask task control<br>
<br>
Martin Jansa (4):<br>
 =C2=A0 =C2=A0 =C2=A0setup.py: also install bitbake-{layers,diffsigs} scrip=
ts<br>
 =C2=A0 =C2=A0 =C2=A0setup.py: install fetch2 module<br>
 =C2=A0 =C2=A0 =C2=A0fetch2/git: fix logger.debug<br>
 =C2=A0 =C2=A0 =C2=A0fetch2/git: be more carefull in _contains_ref when che=
cking git log output<br>
<br>
Matthew McClintock (2):<br>
 =C2=A0 =C2=A0 =C2=A0fetch2/git: Make git fetch run with -f so rebased bran=
ches don&#39;t fail<br>
 =C2=A0 =C2=A0 =C2=A0fetch2: Export additional variables to the fetchers<br=
>
<br>
Otavio Salvador (2):<br>
 =C2=A0 =C2=A0 =C2=A0codeparser.py: fix syntax error in exception handling<=
br>
 =C2=A0 =C2=A0 =C2=A0codeparser.py: fix syntax error in exception handling<=
br>
<br>
Paul Eggleton (31):<br>
 =C2=A0 =C2=A0 =C2=A0bitbake: use layer priority when applying bbappends<br=
>
 =C2=A0 =C2=A0 =C2=A0bitbake/runqueue: fix clash when setscene &amp; real t=
asks done in same build<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/runqueue: show correct task name for setscene =
task failure<br>
 =C2=A0 =C2=A0 =C2=A0track skipped packages<br>
 =C2=A0 =C2=A0 =C2=A0bitbake-layers: handle skipped recipes<br>
 =C2=A0 =C2=A0 =C2=A0bitbake: track &#39;overlayed&#39; recipes<br>
 =C2=A0 =C2=A0 =C2=A0bitbake-layers: add show_overlayed action<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/cooker: implement layer dependencies, make pri=
ority optional<br>
 =C2=A0 =C2=A0 =C2=A0bitbake-layers: add command to flatten layers into one=
<br>
 =C2=A0 =C2=A0 =C2=A0bitbake-layers: fix sorting of show_appends output<br>
 =C2=A0 =C2=A0 =C2=A0bitbake-layers: fix sorting by package name for cooker=
 change<br>
 =C2=A0 =C2=A0 =C2=A0bitbake-layers: fix error on startup caused by recent =
cooker change<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/ast: include class name when arguments given i=
n variant<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/cache: allow class names with arguments to be =
specified<br>
 =C2=A0 =C2=A0 =C2=A0add note to -b option indicating no dependency handlin=
g<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/cooker: show a warning when -b is specified<br=
>
 =C2=A0 =C2=A0 =C2=A0adjust comments/messages for default server change<br>
 =C2=A0 =C2=A0 =C2=A0bitbake-layers: check for errors before parsing<br>
 =C2=A0 =C2=A0 =C2=A0bitbake-layers: add command help<br>
 =C2=A0 =C2=A0 =C2=A0bitbake-layers: remove unneeded do_EOF<br>
 =C2=A0 =C2=A0 =C2=A0bitbake: show more information for NoProvider errors<b=
r>
 =C2=A0 =C2=A0 =C2=A0bitbake/taskdata: fix incorrect usage of rdependees in=
stead of dependees<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/providers: list PREFERRED_VERSION candidates w=
hen unavailable<br>
 =C2=A0 =C2=A0 =C2=A0bitbake-layers: improve default command help<br>
 =C2=A0 =C2=A0 =C2=A0bitbake-layers: show help with no command specified<br=
>
 =C2=A0 =C2=A0 =C2=A0bitbake-layers: use logger.plain instead of info<br>
 =C2=A0 =C2=A0 =C2=A0bitbake-layers: extend show_layers<br>
 =C2=A0 =C2=A0 =C2=A0hob: clear out temporary file list after deleting<br>
 =C2=A0 =C2=A0 =C2=A0hob: fix segfault on second build<br>
 =C2=A0 =C2=A0 =C2=A0fetch2/git: fix subpath destination directory<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/lib/bb/msg.py: fix setting debug and verbosity=
 levels<br>
<br>
Richard Purdie (112):<br>
 =C2=A0 =C2=A0 =C2=A0Increment version for development version<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/siggen.py: Fix whitelisted variable handling<b=
r>
 =C2=A0 =C2=A0 =C2=A0bitbake/build.py: Rename message field to avoid Deprec=
ationWarning: BaseException.message warning<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/utils.py: Add option of holding shared lockfil=
es<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/utils.py: Teach unlockfile about shared mode l=
ockfiles<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/providers.py: Fix runtime providers problems<b=
r>
 =C2=A0 =C2=A0 =C2=A0bitbake/utils: Ignore OSError in unlockfile<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/unlockfile: Fix exception handling<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/build.py: When looking up extra stamp info for=
 setscene tasks, use the real taskname<br>
 =C2=A0 =C2=A0 =C2=A0process.py: Avoid deprecation warning<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/fetch2: Fix message about md5 checksums when s=
ha256 is incorrect<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/fetch2: Pass over malformatted (empty) mirror =
url lines<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/fetch2: Correctly handle git mirror tarball fe=
tching<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/fetch2: Ensure failed fetch attempts are logge=
d in the debug logs<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/fetch2/wget: Fix missing string parameter refe=
rence<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/fetch2: Ensure network access status is reset =
for each loop iteration in download()<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/fetch2: Add some debug output so its clear whe=
n PREMIRRORS, upstream and MIRRORS are being used<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/fetch2: Fix patch merge error<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/fetch2: Add explict network access exception a=
nd handling to give users usable error messages<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/fetch2: Revert part of the unpack change until=
 the issues with it are resolved<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/fecth2: Ensure BB_FETCH_PREMIRRORONLY being se=
t as false is handled correctly<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/cooker: Fix parsing failure zombie problem<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/fetch2: Ensure SRCREV_pn-PN is checked for a r=
evision when the SRC_URI is unnamed<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/data_smart: Improve the way lazyassignment wor=
ks<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/data_smart: Improve Variable expansion error h=
andling<br>
 =C2=A0 =C2=A0 =C2=A0build.py: Improve exec_task standalone usage<br>
 =C2=A0 =C2=A0 =C2=A0build.py: Operate logfile handling at the task level<b=
r>
 =C2=A0 =C2=A0 =C2=A0bitbake/utils.py: Allow join_deps to return a list tha=
t isn&#39;t comman separated<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/ast.py: Only run finalise() for the specified =
variant<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/cooker/codeparser: Ensure the code parser cach=
e is saved for each parsing process<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/cache.py: Ensure skipped recipes make it into =
the cache to avoid reparsing<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/codeparser: Correctly handle a missing/empty c=
ache file<br>
 =C2=A0 =C2=A0 =C2=A0build.py: Fix ordering bug introduced in 7a29ab534388c=
0095f7f826b16c5cff343927d10<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/fetch2/git: Fix a bug where AUTOREV and the gi=
t fetcher interact badly<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/fetch2: Fix the problems introduced by the git=
 fetcher AUTOREV fix<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/fetch2: Allow local file:// urls to be found o=
n mirrors<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/fetch2/local: Fix inverted update required log=
ic<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/utils.py: Only try and add read access to a fi=
le if we don&#39;t have it<br>
 =C2=A0 =C2=A0 =C2=A0codeparser.py: Ignore incomplete cache files<br>
 =C2=A0 =C2=A0 =C2=A0codeparser.py: Ignore incomplete cache files<br>
 =C2=A0 =C2=A0 =C2=A0build/siggen: Ensure a task signature file is generate=
d for each task that is executed<br>
 =C2=A0 =C2=A0 =C2=A0cooker.py: Don&#39;t show spurious warnings for collec=
tions of .bbappend files<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/cooker.py: Fix -b option regexp handling<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/cooker.py: Ensure BBFILES is processed in orde=
r<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/utils.py: Add option to lockfiles to return im=
mediately rather than wait<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/runqueue.py: Ensure existing setscene stamp fi=
les are taken into account<br>
 =C2=A0 =C2=A0 =C2=A0runqueue.py: Set BB_WORKERCONTEXT in task execution co=
ntext<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/codeparser: Improve cache handling<br>
 =C2=A0 =C2=A0 =C2=A0providers.py: Correct PREFERRED_VERSION handling<br>
 =C2=A0 =C2=A0 =C2=A0data_smart: Adding overrides of zero length is pointle=
ss so lets not<br>
 =C2=A0 =C2=A0 =C2=A0cache.py: Sync what amounts to whitespace with bitbake=
 in poky, pending merge of cache patches<br>
 =C2=A0 =C2=A0 =C2=A0cooker/process.py: Move profiling code to a place it c=
an be reused by different server mechanisms<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/runqueue: When we successfully fork off a task=
 and there are more processes we can start do so immediately<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/runqueue: When we have successfully collected =
a pid value return True to ensure we don&#39;t sleep in the main loop<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/cooker: Ensure delays are accurately transfere=
d to the idle loops from runqueue<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/cooker.py: Fix debug message arguments<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/server/process: Move implementation knowledge =
of event queue into the server<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/server: Move server specific code into the ser=
ver backend and create a server API<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/server: Add the none server back for now<br>
 =C2=A0 =C2=A0 =C2=A0xmlrpc/event: Add ability to send pickled events to UI=
 if requested<br>
 =C2=A0 =C2=A0 =C2=A0hob/crumbs/hobeventhandler: Remove server specific imp=
lementation details missed in the precious cleanup<br>
 =C2=A0 =C2=A0 =C2=A0knotty: If any error messages are seen, set our exit c=
ode accordingly<br>
 =C2=A0 =C2=A0 =C2=A0data.py: Ensure vardeps flags get expanded<br>
 =C2=A0 =C2=A0 =C2=A0runqueue.py: Export further hash information into the =
task environment<br>
 =C2=A0 =C2=A0 =C2=A0bitbake-layers: Add comment header<br>
 =C2=A0 =C2=A0 =C2=A0build/runqueue: Pass quieterrors flag around to supres=
s errors at task execution time<br>
 =C2=A0 =C2=A0 =C2=A0cooker.py: Drop duplicate parseCommandLine call<br>
 =C2=A0 =C2=A0 =C2=A0Drop psyco support<br>
 =C2=A0 =C2=A0 =C2=A0persist_data: Add back code to retry in the case of lo=
cked database errors<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/data_smart: Change overrides behaviour to remo=
ve expanded variables from the datastore<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/parse/ast: We always need to finalize the defa=
ult data since otherwise overrides to BBCLASSEXTEND may not be applied<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/event/ast: Add RecipePreFinalise event<br>
 =C2=A0 =C2=A0 =C2=A0Update version to 1.13.1<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/cooker: Fix -b option by ensuring the empty ca=
che structure is present<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/fetch2: When replacing URLs in mirror handling=
 mask out empty entries<br>
 =C2=A0 =C2=A0 =C2=A0codeparser: When loading the cache, ignore ValueError<=
br>
 =C2=A0 =C2=A0 =C2=A0process.py: Fix issue where early errors weren&#39;t m=
aking it to the console<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/data_smart: Optimise the data store iterator<b=
r>
 =C2=A0 =C2=A0 =C2=A0bitbake/data_smart: Don&#39;t export deleted/empty ent=
ries in the list of keys<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/data_smart: Don&#39;t track overrides in delet=
ed variable names<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/ast: Call expandkeys after the RecipePreFinali=
se event<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/ast: Add optional argument for BBCLASSEXTEND<b=
r>
 =C2=A0 =C2=A0 =C2=A0Update version to 1.13.2<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/ast: Fix ??=3D vs. ?=3D handling<br>
 =C2=A0 =C2=A0 =C2=A0ui/depexp: If we&#39;re parsing zero files we need to =
ensure the cache progress bar gets hidden<br>
 =C2=A0 =C2=A0 =C2=A0cache.py: Ensure additional .bbappend files are accoun=
ted for<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/process.py: Ensure queued UI events are queued=
 right before we add our own handler<br>
 =C2=A0 =C2=A0 =C2=A0fetch2/git: Tweak git fetcher to handling repo updates=
 correctly<br>
 =C2=A0 =C2=A0 =C2=A0parse/ConfHandler: Fix multiline variable corruption<b=
r>
 =C2=A0 =C2=A0 =C2=A0Merge remote-tracking branch &#39;origin/master&#39;<b=
r>
 =C2=A0 =C2=A0 =C2=A0bitbake/utils: Add contains helper function from lib.o=
e.utils<br>
 =C2=A0 =C2=A0 =C2=A0Update version to 1.13.3<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/utils: &#39;Fix&#39; bb.utils.contains() behav=
iour<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/ui/knotty: Ensure &#39;No Provider&#39; errors=
 set an exit code<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/ui/knotty: Ensure previous failures aren&#39;t=
 masked by a final successful command<br>
 =C2=A0 =C2=A0 =C2=A0bitbake: Fix -e when used with -b option<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/usermanual: Update to be more in sync with bit=
bake codebase<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/logging: Overhaul internal logging process<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/msg.py: Drop manually created domain lists<br>
 =C2=A0 =C2=A0 =C2=A0build.py: Fix cut and paste error<br>
 =C2=A0 =C2=A0 =C2=A0Fixup remaining bb.msg.domain users<br>
 =C2=A0 =C2=A0 =C2=A0fetch2/git: Add rsync as a valid git protocol<br>
 =C2=A0 =C2=A0 =C2=A0usermanual: The git fetcher defaults to the git protoc=
ol (or file)<br>
 =C2=A0 =C2=A0 =C2=A0bitbake: Correctly handle multiline comments including=
 whitespace<br>
 =C2=A0 =C2=A0 =C2=A0bitbake/fetch2/git: Ensure .gitconfig file is ignored<=
br>
 =C2=A0 =C2=A0 =C2=A0bitbake/event: Allow event handlers to quietly raise S=
kipPackage events<br>
 =C2=A0 =C2=A0 =C2=A0runqueue: Ensure task environment is correct<br>
 =C2=A0 =C2=A0 =C2=A0runqueue.py: Ensure fakeroot variables are reflected i=
n the datastore<br>
 =C2=A0 =C2=A0 =C2=A0git.py: Fix logging vs logger typo<br>
 =C2=A0 =C2=A0 =C2=A0cooker.py: Fix key expansion issues in showVersions<br=
>
 =C2=A0 =C2=A0 =C2=A0Merge branch &#39;master&#39; of git.openembedded.org:=
bitbake<br>
 =C2=A0 =C2=A0 =C2=A0Release 1.14.0<br>
<br>
Robert Yang (1):<br>
 =C2=A0 =C2=A0 =C2=A0bitbake: Add task specific stamp file support<br>
<br>
Saul Wold (1):<br>
 =C2=A0 =C2=A0 =C2=A0universe target: add a new target to collect all recip=
e targets<br>
<br>
Scott Garman (3):<br>
 =C2=A0 =C2=A0 =C2=A0cache.py: fix bitbake -s command<br>
 =C2=A0 =C2=A0 =C2=A0make exception handling syntax consistent<br>
 =C2=A0 =C2=A0 =C2=A0fetch2/git.py: improve error reporting when an invalid=
 protocol is used<br>
<br>
Yu Ke (8):<br>
 =C2=A0 =C2=A0 =C2=A0git fetcher: make tag back to work, fix Yocto bug 972<=
br>
 =C2=A0 =C2=A0 =C2=A0git fetcher: add support for rebaseable git repo<br>
 =C2=A0 =C2=A0 =C2=A0fetch2/git: change default protocol from rsync to git<=
br>
 =C2=A0 =C2=A0 =C2=A0fetch2/git: unify the nocheckout option format<br>
 =C2=A0 =C2=A0 =C2=A0fetch2/git: add document for git fetcher supported opt=
ions<br>
 =C2=A0 =C2=A0 =C2=A0fetch2/git: enhance the unpack by using &quot;git chec=
kout&quot;<br>
 =C2=A0 =C2=A0 =C2=A0fetcher2: retry mirror if upstream checksum mismatch<b=
r>
 =C2=A0 =C2=A0 =C2=A0fetcher2: show warning message when checksum is mismat=
ch<br>
<br>
<br>
<br>
_______________________________________________<br>
Openembedded-core mailing list<br>
<a href=3D"mailto:Openembedded-core@lists.openembedded.org">Openembedded-co=
re@lists.openembedded.org</a><br>
<a href=3D"http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/openembedded=
-core" target=3D"_blank">http://lists.linuxtogo.org/cgi-bin/mailman/listinf=
o/openembedded-core</a><br>
</blockquote></div><br></div>

--0015175117f247058204b0e9343f--
