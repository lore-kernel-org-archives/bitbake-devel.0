Return-Path: <jason.wessel@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id C5D2F6E8A2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Mar 2014 12:56:46 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.5) with ESMTP id s2SCujM6008525
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Fri, 28 Mar 2014 05:56:45 -0700 (PDT)
Received: from [172.25.32.43] (172.25.32.43) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.3.169.1;
	Fri, 28 Mar 2014 05:56:44 -0700
Message-ID: <5335718B.3070709@windriver.com>
Date: Fri, 28 Mar 2014 07:56:43 -0500
From: Jason Wessel <jason.wessel@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:24.0) Gecko/20100101 Thunderbird/24.3.0
MIME-Version: 1.0
To: Alex Damian <alex.r.damian@gmail.com>, Cristiana Voicu
	<cristiana.voicu@intel.com>
References: <1395821145-2242-1-git-send-email-cristiana.voicu@intel.com>
	<CAL7ttbdPWNTANmGEEK9T7OwQ7HY0j1xtMdhJeOdouvEZ__cvwQ@mail.gmail.com>
In-Reply-To: <CAL7ttbdPWNTANmGEEK9T7OwQ7HY0j1xtMdhJeOdouvEZ__cvwQ@mail.gmail.com>
X-Enigmail-Version: 1.6
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] cooker: bitbake memres server should not always reload the cache
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 28 Mar 2014 12:56:49 -0000
Content-Type: multipart/alternative;
	boundary="------------000900040809030107030003"

--------------000900040809030107030003
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

On 03/28/2014 06:43 AM, Alex Damian wrote:
> Please hold merging this change.
>
> I think we need to discuss a bit on this. My expectation is that the Bitbake server will reinit its state between builds, re-parsing the configuration files and reload the cache.
> I am not sure why we would consider maintaining the hot cache copy in memory between builds.
>


It is about increasing the interactivity of the system.  There are certainly times you need to soft reset, but perhaps that is what we need to expose.  If I want to run a dev shell and have done a build, this is something I'd like to be instantaneous, or if I am working on the package and want to re-run the compile and package steps, there really is no need to parse. 

There is a trade off for the individual package work vs the work of rebuilding the entire image.  In the case of the entire image you most certainly want the soft reset behavior.

Just some food for thought.

Cheers,
Jason.


> The patch for bug https://bugzilla.yoctoproject.org/show_bug.cgi?id=5535 will re-create the exact same scenario that we try to change through this patch, so
> I think we need to clarify the issue before moving forward.
>
> Thanks,
> Alex
>
>
> On Wed, Mar 26, 2014 at 8:05 AM, Cristiana Voicu <cristiana.voicu@intel.com <mailto:cristiana.voicu@intel.com>> wrote:
>
>     Due to commit dd15648fc2654b8d7c3e00ea7ab3dbf04f24f24b, after an async
>     command is executed, the state of the server is set back to state.initial,
>     so the cache is always reloaded.
>     This patch adds a sanity check on the validity of the cache and then only
>     reload if something has changed.
>     depends_cache variable is needed in this case, so the del statement needs
>     to be removed.
>
>     [YOCTO #5603]
>     Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com <mailto:cristiana.voicu@intel.com>>
>     ---
>      bitbake/lib/bb/cache.py  |    2 --
>      bitbake/lib/bb/cooker.py |   32 ++++++++++++++++++++++----------
>      2 files changed, 22 insertions(+), 12 deletions(-)
>
>     diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
>     index 318781b..da9ad5d 100644
>     --- a/bitbake/lib/bb/cache.py
>     +++ b/bitbake/lib/bb/cache.py
>     @@ -612,8 +612,6 @@ class Cache(object):
>                          cache_class_name = cache_class.__name__
>                          file_dict[cache_class_name].close()
>
>     -        del self.depends_cache
>     -
>          @staticmethod
>          def mtime(cachefile):
>              return bb.parse.cached_mtime_noerror(cachefile)
>     diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
>     index 07202e3..c90bb44 100644
>     --- a/bitbake/lib/bb/cooker.py
>     +++ b/bitbake/lib/bb/cooker.py
>     @@ -1265,21 +1265,33 @@ class BBCooker:
>                  raise bb.BBHandledException()
>
>              if self.state != state.parsing:
>     -            self.parseConfiguration ()
>     +            check_cache = False
>     +            if self.parser:
>     +                self.parser.bb_cache.checked = set()
>     +                for filename in self.parser.filelist:
>     +                    appends = self.collection.get_file_appends(filename)
>     +                    if not self.parser.bb_cache.cacheValid(filename, appends):
>     +                        check_cache = True
>     +                        break
>     +            else:
>     +                check_cache = True
>
>     -            ignore = self.data.getVar("ASSUME_PROVIDED", True) or ""
>     -            self.recipecache.ignored_dependencies = set(ignore.split())
>     +            if check_cache:
>     +                self.parseConfiguration ()
>     +
>     +                ignore = self.data.getVar("ASSUME_PROVIDED", True) or ""
>     +                self.recipecache.ignored_dependencies = set(ignore.split())
>
>     -            for dep in self.configuration.extra_assume_provided:
>     -                self.recipecache.ignored_dependencies.add(dep)
>     +                for dep in self.configuration.extra_assume_provided:
>     +                    self.recipecache.ignored_dependencies.add(dep)
>
>     -            self.collection = CookerCollectFiles(self.recipecache.bbfile_config_priorities)
>     -            (filelist, masked) = self.collection.collect_bbfiles(self.data, self.event_data)
>     +                self.collection = CookerCollectFiles(self.recipecache.bbfile_config_priorities)
>     +                (filelist, masked) = self.collection.collect_bbfiles(self.data, self.event_data)
>
>     -            self.data.renameVar("__depends", "__base_depends")
>     +                self.data.renameVar("__depends", "__base_depends")
>
>     -            self.parser = CookerParser(self, filelist, masked)
>     -            self.state = state.parsing
>     +                self.parser = CookerParser(self, filelist, masked)
>     +                self.state = state.parsing
>
>              if not self.parser.parse_next():
>                  collectlog.debug(1, "parsing complete")
>     --
>     1.7.9.5
>
>     --
>     _______________________________________________
>     bitbake-devel mailing list
>     bitbake-devel@lists.openembedded.org <mailto:bitbake-devel@lists.openembedded.org>
>     http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>
>
>
>


--------------000900040809030107030003
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">On 03/28/2014 06:43 AM, Alex Damian
      wrote:<br>
    </div>
    <blockquote
cite="mid:CAL7ttbdPWNTANmGEEK9T7OwQ7HY0j1xtMdhJeOdouvEZ__cvwQ@mail.gmail.com"
      type="cite">
      <meta http-equiv="Context-Type" content="text/html;
        charset=ISO-8859-1">
      <div dir="ltr">
        <div>
          <div>
            <div>
              <div>Please hold merging this change.<br>
                <br>
              </div>
              I think we need to discuss a bit on this. My expectation
              is that the Bitbake server will reinit its state between
              builds, re-parsing the configuration files and reload the
              cache.<br>
            </div>
            <div>I am not sure why we would consider maintaining the hot
              cache copy in memory between builds.<br>
            </div>
            <div><br>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
    <br>
    It is about increasing the interactivity of the system.&nbsp; There are
    certainly times you need to soft reset, but perhaps that is what we
    need to expose.&nbsp; If I want to run a dev shell and have done a build,
    this is something I'd like to be instantaneous, or if I am working
    on the package and want to re-run the compile and package steps,
    there really is no need to parse.&nbsp; <br>
    <br>
    There is a trade off for the individual package work vs the work of
    rebuilding the entire image.&nbsp; In the case of the entire image you
    most certainly want the soft reset behavior. <br>
    <br>
    Just some food for thought.<br>
    <br>
    Cheers,<br>
    Jason.<br>
    <br>
    <br>
    <blockquote
cite="mid:CAL7ttbdPWNTANmGEEK9T7OwQ7HY0j1xtMdhJeOdouvEZ__cvwQ@mail.gmail.com"
      type="cite">
      <div dir="ltr">
        <div>
          <div>The patch for bug <a moz-do-not-send="true"
              href="https://bugzilla.yoctoproject.org/show_bug.cgi?id=5535">https://bugzilla.yoctoproject.org/show_bug.cgi?id=5535</a>
            will re-create the exact same scenario that we try to change
            through this patch, so <br>
          </div>
          I think we need to clarify the issue before moving forward.<br>
          <br>
        </div>
        Thanks,<br>
        Alex<br>
      </div>
      <div class="gmail_extra"><br>
        <br>
        <div class="gmail_quote">On Wed, Mar 26, 2014 at 8:05 AM,
          Cristiana Voicu <span dir="ltr">&lt;<a moz-do-not-send="true"
              href="mailto:cristiana.voicu@intel.com" target="_blank">cristiana.voicu@intel.com</a>&gt;</span>
          wrote:<br>
          <blockquote class="gmail_quote">Due to commit
            dd15648fc2654b8d7c3e00ea7ab3dbf04f24f24b, after an async<br>
            command is executed, the state of the server is set back to
            state.initial,<br>
            so the cache is always reloaded.<br>
            This patch adds a sanity check on the validity of the cache
            and then only<br>
            reload if something has changed.<br>
            depends_cache variable is needed in this case, so the del
            statement needs<br>
            to be removed.<br>
            <br>
            [YOCTO #5603]<br>
            Signed-off-by: Cristiana Voicu &lt;<a moz-do-not-send="true"
              href="mailto:cristiana.voicu@intel.com">cristiana.voicu@intel.com</a>&gt;<br>
            ---<br>
            &nbsp;bitbake/lib/bb/cache.py &nbsp;| &nbsp; &nbsp;2 --<br>
            &nbsp;bitbake/lib/bb/cooker.py | &nbsp; 32
            ++++++++++++++++++++++----------<br>
            &nbsp;2 files changed, 22 insertions(+), 12 deletions(-)<br>
            <br>
            diff --git a/bitbake/lib/bb/cache.py
            b/bitbake/lib/bb/cache.py<br>
            index 318781b..da9ad5d 100644<br>
            --- a/bitbake/lib/bb/cache.py<br>
            +++ b/bitbake/lib/bb/cache.py<br>
            @@ -612,8 +612,6 @@ class Cache(object):<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;cache_class_name = cache_class.__name__<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;file_dict[cache_class_name].close()<br>
            <br>
            - &nbsp; &nbsp; &nbsp; &nbsp;del self.depends_cache<br>
            -<br>
            &nbsp; &nbsp; &nbsp;@staticmethod<br>
            &nbsp; &nbsp; &nbsp;def mtime(cachefile):<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return bb.parse.cached_mtime_noerror(cachefile)<br>
            diff --git a/bitbake/lib/bb/cooker.py
            b/bitbake/lib/bb/cooker.py<br>
            index 07202e3..c90bb44 100644<br>
            --- a/bitbake/lib/bb/cooker.py<br>
            +++ b/bitbake/lib/bb/cooker.py<br>
            @@ -1265,21 +1265,33 @@ class BBCooker:<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;raise bb.BBHandledException()<br>
            <br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if self.state != state.parsing:<br>
            - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;self.parseConfiguration ()<br>
            + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;check_cache = False<br>
            + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if self.parser:<br>
            + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;self.parser.bb_cache.checked = set()<br>
            + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;for filename in self.parser.filelist:<br>
            + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;appends =
            self.collection.get_file_appends(filename)<br>
            + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if not
            self.parser.bb_cache.cacheValid(filename, appends):<br>
            + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;check_cache = True<br>
            + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;break<br>
            + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;else:<br>
            + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;check_cache = True<br>
            <br>
            - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ignore = self.data.getVar("ASSUME_PROVIDED",
            True) or ""<br>
            - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;self.recipecache.ignored_dependencies =
            set(ignore.split())<br>
            + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if check_cache:<br>
            + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;self.parseConfiguration ()<br>
            +<br>
            + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ignore =
            self.data.getVar("ASSUME_PROVIDED", True) or ""<br>
            + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;self.recipecache.ignored_dependencies =
            set(ignore.split())<br>
            <br>
            - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;for dep in
            self.configuration.extra_assume_provided:<br>
            - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp;self.recipecache.ignored_dependencies.add(dep)<br>
            + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;for dep in
            self.configuration.extra_assume_provided:<br>
            + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp;self.recipecache.ignored_dependencies.add(dep)<br>
            <br>
            - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;self.collection =
            CookerCollectFiles(self.recipecache.bbfile_config_priorities)<br>
            - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(filelist, masked) =
            self.collection.collect_bbfiles(self.data, self.event_data)<br>
            + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;self.collection =
            CookerCollectFiles(self.recipecache.bbfile_config_priorities)<br>
            + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(filelist, masked) =
            self.collection.collect_bbfiles(self.data, self.event_data)<br>
            <br>
            - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;self.data.renameVar("__depends",
            "__base_depends")<br>
            + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;self.data.renameVar("__depends",
            "__base_depends")<br>
            <br>
            - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;self.parser = CookerParser(self, filelist,
            masked)<br>
            - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;self.state = state.parsing<br>
            + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;self.parser = CookerParser(self, filelist,
            masked)<br>
            + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;self.state = state.parsing<br>
            <br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if not self.parser.parse_next():<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;collectlog.debug(1, "parsing complete")<br>
            <span class="HOEnZb">--<br>
              1.7.9.5<br>
              <br>
              --<br>
              _______________________________________________<br>
              bitbake-devel mailing list<br>
              <a moz-do-not-send="true"
                href="mailto:bitbake-devel@lists.openembedded.org">bitbake-devel@lists.openembedded.org</a><br>
              <a moz-do-not-send="true"
                href="http://lists.openembedded.org/mailman/listinfo/bitbake-devel"
                target="_blank">http://lists.openembedded.org/mailman/listinfo/bitbake-devel</a><br>
            </span></blockquote>
        </div>
        <br>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
    </blockquote>
    <br>
  </body>
</html>

--------------000900040809030107030003--
