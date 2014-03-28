Return-Path: <alex.r.damian@gmail.com>
Received: from mail-qg0-f45.google.com (mail-qg0-f45.google.com
	[209.85.192.45])
	by mail.openembedded.org (Postfix) with ESMTP id 1DCCD60E79
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Mar 2014 11:43:25 +0000 (UTC)
Received: by mail-qg0-f45.google.com with SMTP id j5so4147088qga.4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Mar 2014 04:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=SaACDxPQriom97pNd4NGylyOnNGrFEvc72YwztNS9x0=;
	b=ErU6XPdujfxzC/T9TV48dlM1M139ot5BksRoqh1zz4NoG9GGeyFQz9Gy7cSKFnGdlU
	fNXflylwdJcNsGaHTXO/ZIW7xTlwENg5gydgUN8P4MCxUUA4OZinQSrHbNGbuLfjk3MZ
	0WmW4hhRvv95PW76mdhrh1wsAhe9iVHlRC6op/teDuzq9vIZecd4nbLYyQsH3W1ETrpi
	RDi57t+SQ0p00GH4R6ONuCn1rWL2zQHAJbH2POo14yclBsGkTGfI7IdUOD6NChMluRky
	/ba9aQVbaFoDWLipoejC2Z59CCv7AQBCeYY0eWkJ5vAxluwb5XIWpT1XIHW7mP7aBTKE
	nR9A==
MIME-Version: 1.0
X-Received: by 10.140.87.151 with SMTP id r23mr8103159qgd.23.1396007006055;
	Fri, 28 Mar 2014 04:43:26 -0700 (PDT)
Received: by 10.224.207.135 with HTTP; Fri, 28 Mar 2014 04:43:25 -0700 (PDT)
In-Reply-To: <1395821145-2242-1-git-send-email-cristiana.voicu@intel.com>
References: <1395821145-2242-1-git-send-email-cristiana.voicu@intel.com>
Date: Fri, 28 Mar 2014 11:43:25 +0000
Message-ID: <CAL7ttbdPWNTANmGEEK9T7OwQ7HY0j1xtMdhJeOdouvEZ__cvwQ@mail.gmail.com>
From: Alex Damian <alex.r.damian@gmail.com>
To: Cristiana Voicu <cristiana.voicu@intel.com>
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
X-List-Received-Date: Fri, 28 Mar 2014 11:43:27 -0000
Content-Type: multipart/alternative; boundary=001a11c13d64b332b904f5a93547

--001a11c13d64b332b904f5a93547
Content-Type: text/plain; charset=ISO-8859-1

Please hold merging this change.

I think we need to discuss a bit on this. My expectation is that the
Bitbake server will reinit its state between builds, re-parsing the
configuration files and reload the cache.
I am not sure why we would consider maintaining the hot cache copy in
memory between builds.

The patch for bug
https://bugzilla.yoctoproject.org/show_bug.cgi?id=5535will re-create
the exact same scenario that we try to change through this
patch, so
I think we need to clarify the issue before moving forward.

Thanks,
Alex


On Wed, Mar 26, 2014 at 8:05 AM, Cristiana Voicu
<cristiana.voicu@intel.com>wrote:

> Due to commit dd15648fc2654b8d7c3e00ea7ab3dbf04f24f24b, after an async
> command is executed, the state of the server is set back to state.initial,
> so the cache is always reloaded.
> This patch adds a sanity check on the validity of the cache and then only
> reload if something has changed.
> depends_cache variable is needed in this case, so the del statement needs
> to be removed.
>
> [YOCTO #5603]
> Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
> ---
>  bitbake/lib/bb/cache.py  |    2 --
>  bitbake/lib/bb/cooker.py |   32 ++++++++++++++++++++++----------
>  2 files changed, 22 insertions(+), 12 deletions(-)
>
> diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
> index 318781b..da9ad5d 100644
> --- a/bitbake/lib/bb/cache.py
> +++ b/bitbake/lib/bb/cache.py
> @@ -612,8 +612,6 @@ class Cache(object):
>                      cache_class_name = cache_class.__name__
>                      file_dict[cache_class_name].close()
>
> -        del self.depends_cache
> -
>      @staticmethod
>      def mtime(cachefile):
>          return bb.parse.cached_mtime_noerror(cachefile)
> diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> index 07202e3..c90bb44 100644
> --- a/bitbake/lib/bb/cooker.py
> +++ b/bitbake/lib/bb/cooker.py
> @@ -1265,21 +1265,33 @@ class BBCooker:
>              raise bb.BBHandledException()
>
>          if self.state != state.parsing:
> -            self.parseConfiguration ()
> +            check_cache = False
> +            if self.parser:
> +                self.parser.bb_cache.checked = set()
> +                for filename in self.parser.filelist:
> +                    appends = self.collection.get_file_appends(filename)
> +                    if not self.parser.bb_cache.cacheValid(filename,
> appends):
> +                        check_cache = True
> +                        break
> +            else:
> +                check_cache = True
>
> -            ignore = self.data.getVar("ASSUME_PROVIDED", True) or ""
> -            self.recipecache.ignored_dependencies = set(ignore.split())
> +            if check_cache:
> +                self.parseConfiguration ()
> +
> +                ignore = self.data.getVar("ASSUME_PROVIDED", True) or ""
> +                self.recipecache.ignored_dependencies =
> set(ignore.split())
>
> -            for dep in self.configuration.extra_assume_provided:
> -                self.recipecache.ignored_dependencies.add(dep)
> +                for dep in self.configuration.extra_assume_provided:
> +                    self.recipecache.ignored_dependencies.add(dep)
>
> -            self.collection =
> CookerCollectFiles(self.recipecache.bbfile_config_priorities)
> -            (filelist, masked) =
> self.collection.collect_bbfiles(self.data, self.event_data)
> +                self.collection =
> CookerCollectFiles(self.recipecache.bbfile_config_priorities)
> +                (filelist, masked) =
> self.collection.collect_bbfiles(self.data, self.event_data)
>
> -            self.data.renameVar("__depends", "__base_depends")
> +                self.data.renameVar("__depends", "__base_depends")
>
> -            self.parser = CookerParser(self, filelist, masked)
> -            self.state = state.parsing
> +                self.parser = CookerParser(self, filelist, masked)
> +                self.state = state.parsing
>
>          if not self.parser.parse_next():
>              collectlog.debug(1, "parsing complete")
> --
> 1.7.9.5
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>

--001a11c13d64b332b904f5a93547
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div>Please hold merging this change.<br><b=
r></div>I think we need to discuss a bit on this. My expectation is that th=
e Bitbake server will reinit its state between builds, re-parsing the confi=
guration files and reload the cache.<br>
</div><div>I am not sure why we would consider maintaining the hot cache co=
py in memory between builds.<br></div><div><br></div>The patch for bug <a h=
ref=3D"https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D5535">https://bu=
gzilla.yoctoproject.org/show_bug.cgi?id=3D5535</a> will re-create the exact=
 same scenario that we try to change through this patch, so <br>
</div>I think we need to clarify the issue before moving forward.<br><br></=
div>Thanks,<br>Alex<br></div><div class=3D"gmail_extra"><br><br><div class=
=3D"gmail_quote">On Wed, Mar 26, 2014 at 8:05 AM, Cristiana Voicu <span dir=
=3D"ltr">&lt;<a href=3D"mailto:cristiana.voicu@intel.com" target=3D"_blank"=
>cristiana.voicu@intel.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Due to commit dd15648fc2654b8d7c3e00ea7ab3db=
f04f24f24b, after an async<br>
command is executed, the state of the server is set back to state.initial,<=
br>
so the cache is always reloaded.<br>
This patch adds a sanity check on the validity of the cache and then only<b=
r>
reload if something has changed.<br>
depends_cache variable is needed in this case, so the del statement needs<b=
r>
to be removed.<br>
<br>
[YOCTO #5603]<br>
Signed-off-by: Cristiana Voicu &lt;<a href=3D"mailto:cristiana.voicu@intel.=
com">cristiana.voicu@intel.com</a>&gt;<br>
---<br>
=A0bitbake/lib/bb/cache.py =A0| =A0 =A02 --<br>
=A0bitbake/lib/bb/cooker.py | =A0 32 ++++++++++++++++++++++----------<br>
=A02 files changed, 22 insertions(+), 12 deletions(-)<br>
<br>
diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py<br>
index 318781b..da9ad5d 100644<br>
--- a/bitbake/lib/bb/cache.py<br>
+++ b/bitbake/lib/bb/cache.py<br>
@@ -612,8 +612,6 @@ class Cache(object):<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cache_class_name =3D cache_class=
.__name__<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0file_dict[cache_class_name].clos=
e()<br>
<br>
- =A0 =A0 =A0 =A0del self.depends_cache<br>
-<br>
=A0 =A0 =A0@staticmethod<br>
=A0 =A0 =A0def mtime(cachefile):<br>
=A0 =A0 =A0 =A0 =A0return bb.parse.cached_mtime_noerror(cachefile)<br>
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py<br>
index 07202e3..c90bb44 100644<br>
--- a/bitbake/lib/bb/cooker.py<br>
+++ b/bitbake/lib/bb/cooker.py<br>
@@ -1265,21 +1265,33 @@ class BBCooker:<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0raise bb.BBHandledException()<br>
<br>
=A0 =A0 =A0 =A0 =A0if self.state !=3D state.parsing:<br>
- =A0 =A0 =A0 =A0 =A0 =A0self.parseConfiguration ()<br>
+ =A0 =A0 =A0 =A0 =A0 =A0check_cache =3D False<br>
+ =A0 =A0 =A0 =A0 =A0 =A0if self.parser:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0self.parser.bb_cache.checked =3D set()<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for filename in self.parser.filelist:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0appends =3D self.collection.get_fi=
le_appends(filename)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if not self.parser.bb_cache.cacheV=
alid(filename, appends):<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0check_cache =3D True<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break<br>
+ =A0 =A0 =A0 =A0 =A0 =A0else:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0check_cache =3D True<br>
<br>
- =A0 =A0 =A0 =A0 =A0 =A0ignore =3D self.data.getVar(&quot;ASSUME_PROVIDED&=
quot;, True) or &quot;&quot;<br>
- =A0 =A0 =A0 =A0 =A0 =A0self.recipecache.ignored_dependencies =3D set(igno=
re.split())<br>
+ =A0 =A0 =A0 =A0 =A0 =A0if check_cache:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0self.parseConfiguration ()<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ignore =3D self.data.getVar(&quot;ASSUME_P=
ROVIDED&quot;, True) or &quot;&quot;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0self.recipecache.ignored_dependencies =3D =
set(ignore.split())<br>
<br>
- =A0 =A0 =A0 =A0 =A0 =A0for dep in self.configuration.extra_assume_provide=
d:<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0self.recipecache.ignored_dependencies.add(=
dep)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for dep in self.configuration.extra_assume=
_provided:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0self.recipecache.ignored_dependenc=
ies.add(dep)<br>
<br>
- =A0 =A0 =A0 =A0 =A0 =A0self.collection =3D CookerCollectFiles(self.recipe=
cache.bbfile_config_priorities)<br>
- =A0 =A0 =A0 =A0 =A0 =A0(filelist, masked) =3D self.collection.collect_bbf=
iles(self.data, self.event_data)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0self.collection =3D CookerCollectFiles(sel=
f.recipecache.bbfile_config_priorities)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(filelist, masked) =3D self.collection.col=
lect_bbfiles(self.data, self.event_data)<br>
<br>
- =A0 =A0 =A0 =A0 =A0 =A0self.data.renameVar(&quot;__depends&quot;, &quot;_=
_base_depends&quot;)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0self.data.renameVar(&quot;__depends&quot;,=
 &quot;__base_depends&quot;)<br>
<br>
- =A0 =A0 =A0 =A0 =A0 =A0self.parser =3D CookerParser(self, filelist, maske=
d)<br>
- =A0 =A0 =A0 =A0 =A0 =A0self.state =3D state.parsing<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0self.parser =3D CookerParser(self, filelis=
t, masked)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0self.state =3D state.parsing<br>
<br>
=A0 =A0 =A0 =A0 =A0if not self.parser.parse_next():<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0collectlog.debug(1, &quot;parsing complete&quot;=
)<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.7.9.5<br>
<br>
--<br>
_______________________________________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org">bitbake-devel@lists=
.openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" ta=
rget=3D"_blank">http://lists.openembedded.org/mailman/listinfo/bitbake-deve=
l</a><br>
</font></span></blockquote></div><br></div>

--001a11c13d64b332b904f5a93547--
