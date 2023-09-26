Return-Path: <alberto@pianon.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392ECE7E654
	for <webhook@archiver.kernel.org>; Tue, 26 Sep 2023 17:11:06 +0000 (UTC)
Received: from server3.justice4all.it (server3.justice4all.it [95.217.19.36])
 by mx.groups.io with SMTP id smtpd.web11.24973.1695748257754773023
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 26 Sep 2023 10:10:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pianon.eu header.s=mail20151219 header.b=A+D/U9Xc;
 spf=pass (domain: pianon.eu, ip: 95.217.19.36, mailfrom: alberto@pianon.eu)
Received: from localhost (localhost [127.0.0.1])
	by server3.justice4all.it (Postfix) with ESMTP id 1BE825C0096;
	Tue, 26 Sep 2023 19:10:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pianon.eu; h=
	message-id:references:in-reply-to:subject:subject:from:from:date
	:date:content-transfer-encoding:content-type:content-type
	:mime-version; s=mail20151219; t=1695748254; x=1697562655; bh=yT
	kgjvG/fFxTMzXV7fWPyFCPEtLenJQQ8qoYT+QCMT4=; b=A+D/U9Xc6nvcBaUITC
	hpnICvalMR6d29NZukMxDWsmUliBSjrTkaAeBiMcgn9tTgUx2xkfXZs7rWEKjFPz
	jgTeSHChEcKsStu68joXMYKtthFuYzDyXbvRp9REOFoN2oSoYHieBmGLrQ6JmBWB
	tYsoaOqzCySfiLN34TLciqIIE=
X-Virus-Scanned: Debian amavisd-new at server3.justice4all.it
Received: from server3.justice4all.it ([127.0.0.1])
	by localhost (server3.justice4all.it [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id g9aJLedqQMrJ; Tue, 26 Sep 2023 19:10:54 +0200 (CEST)
Received: from pianon.eu (localhost [127.0.0.1])
	(Authenticated sender: alberto@pianon.eu)
	by server3.justice4all.it (Postfix) with ESMTPA id 2C2475C0095;
	Tue, 26 Sep 2023 19:10:54 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 26 Sep 2023 19:10:54 +0200
From: Alberto Pianon <alberto@pianon.eu>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Bitbake Devel <bitbake-devel@lists.openembedded.org>, 'Carlo Piana'
 <carlo@piana.eu>, Joshua Watt <jpewhacker@gmail.com>
Subject: Re: initial idea for hooks needed for source tracing
In-Reply-To: <8e4a6e545b3b2bbe9fc0a053b42521a84ded31da.camel@linuxfoundation.org>
References: <7f5d05fe554d232c300b2604addc452a@pianon.eu>
 <fa1abc9099171f8fb26c60fd29bc4dfd15376f8a.camel@linuxfoundation.org>
 <517df01859172566e88a239658c601be@pianon.eu>
 <bda639e462aa9f7bfd4a04e17d953e23b99ca2b0.camel@linuxfoundation.org>
 <6d0c953729ea7602ee09cc9238513c1b@pianon.eu>
 <8a899d6d88c1d493d48c3a495a9671b13df6a408.camel@linuxfoundation.org>
 <15196a1c207f89bfc8894f155b05cbde@pianon.eu>
 <97ecac758fd3b771e56e32e0a6c095d0900629a3.camel@linuxfoundation.org>
 <bfff73a5d575b2a62fb14782e71e9207@pianon.eu>
 <3b9ec69856ec79e4ec9856d72395b3cbd36e58b2.camel@linuxfoundation.org>
 <d15cebdfe85ce07df53132f3e20861ee@pianon.eu>
 <8e4a6e545b3b2bbe9fc0a053b42521a84ded31da.camel@linuxfoundation.org>
Message-ID: <517a1a06b6ed933a92ade40633b431d7@pianon.eu>
X-Sender: alberto@pianon.eu
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 26 Sep 2023 17:11:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15133


On 2023-09-21 11:00, Richard Purdie wrote:
> On Thu, 2023-09-21 at 08:39 +0200, Alberto Pianon wrote:
>> 
>> So I would apply for an exception here :)
>> Calculating submodule checkout paths (also for nested submodules) and
>> adding them to urldata would require adding just a couple of lines in
>> gitsm.py and would do no harm, I hope... This would be much better 
>> than
>> passing the modpath parameter to the tracer with a special hook: the
>> tracer could just collect the checkout path from urldata and no
>> fetcher-specific hooks would be required. In other words, we would 
>> solve
>> the only problem that's still left (the others should be solved by 
>> using
>> sessions as you suggested).
>> 
>> What do you think?
> 
> That sounds reasonable.
> 
> My concerns are as I previously mentioned, encoding unpack specific
> data into urldata which is effectively invalid after unpack and the
> naming "destdir".
> 
> Cheers,
> 
> Richard

Hi Richard,

finally I got a working patch, tested against a PoC API implementation
(implementation that I will *not* submit for now, as agreed). I tried to
take into account all of your concerns and recommendations (including
your approval to add just checkout dir calculation to the fetcher :) )

I know that this is a busy time for you so I kindly ask you to have
just a quick look the patch below and tell me if we are finally on the
right track, before officially submitting it to the ML.

Thanks,

Alberto

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 765aedd5..21f8f77c 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1578,6 +1578,7 @@ class FetchMethod(object):
              unpackdir = rootdir

          if not unpack or not cmd:
+            urldata.unpack_tracer.unpack("file-copy", unpackdir)
              # If file == dest, then avoid any copies, as we already put 
the file into dest!
              dest = os.path.join(unpackdir, os.path.basename(file))
              if file != dest and not (os.path.exists(dest) and 
os.path.samefile(file, dest)):
@@ -1592,6 +1593,8 @@ class FetchMethod(object):
                          destdir = urlpath.rsplit("/", 1)[0] + '/'
                          bb.utils.mkdirhier("%s/%s" % (unpackdir, 
destdir))
                  cmd = 'cp -fpPRH "%s" "%s"' % (file, destdir)
+        else:
+            urldata.unpack_tracer.unpack("archive-extract", unpackdir)

          if not cmd:
              return
@@ -1683,6 +1686,20 @@ class FetchMethod(object):
          """
          return []

+
+class DummyUnpackTracer(object):
+    def start(self, unpackdir, urldata_dict, d):
+        return
+    def start_url(self, url):
+        return
+    def unpack(self, unpack_type, unpackdir):
+        return
+    def finish_url(self, url):
+        return
+    def complete(self):
+        return
+
+
  class Fetch(object):
      def __init__(self, urls, d, cache = True, localonly = False, 
connection_cache = None):
          if localonly and cache:
@@ -1703,10 +1720,25 @@ class Fetch(object):
          if key in urldata_cache:
              self.ud = urldata_cache[key]

+        global unpack_tracer
+        try:
+            unpack_tracer
+        except NameError:
+            class_path = d.getVar("UNPACK_TRACER_CLASS")
+            if class_path:
+                import importlib
+                module_name, _, class_name = class_path.rpartition(".")
+                module = importlib.import_module(module_name)
+                class_ = getattr(module, class_name)
+                unpack_tracer = class_()
+            else:
+                unpack_tracer = DummyUnpackTracer()
+
          for url in urls:
              if url not in self.ud:
                  try:
                      self.ud[url] = FetchData(url, d, localonly)
+                    self.ud[url].unpack_tracer = unpack_tracer
                  except NonLocalMethod:
                      if localonly:
                          self.ud[url] = None
@@ -1882,6 +1914,8 @@ class Fetch(object):
          if not urls:
              urls = self.urls

+        unpack_tracer.start(root, self.ud, self.d)
+
          for u in urls:
              ud = self.ud[u]
              ud.setup_localpath(self.d)
@@ -1889,11 +1923,15 @@ class Fetch(object):
              if ud.lockfile:
                  lf = bb.utils.lockfile(ud.lockfile)

+            unpack_tracer.start_url(u)
              ud.method.unpack(ud, root, self.d)
+            unpack_tracer.finish_url(u)

              if ud.lockfile:
                  bb.utils.unlockfile(lf)

+        unpack_tracer.complete()
+
      def clean(self, urls=None):
          """
          Clean files that the fetcher gets or places
diff --git a/lib/bb/fetch2/crate.py b/lib/bb/fetch2/crate.py
index 3310ed00..01d49435 100644
--- a/lib/bb/fetch2/crate.py
+++ b/lib/bb/fetch2/crate.py
@@ -101,8 +101,10 @@ class Crate(Wget):
          bp = d.getVar('BP')
          if bp == ud.parm.get('name'):
              cmd = "tar -xz --no-same-owner -f %s" % thefile
+            ud.unpack_tracer.unpack("crate-extract", rootdir)
          else:
              cargo_bitbake = self._cargo_bitbake_path(rootdir)
+            ud.unpack_tracer.unpack("cargo-extract", cargo_bitbake)

              cmd = "tar -xz --no-same-owner -f %s -C %s" % (thefile, 
cargo_bitbake)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 4385d0b3..2039df56 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -589,6 +589,9 @@ class Git(FetchMethod):
          destdir = ud.destdir = os.path.join(destdir, destsuffix)
          if os.path.exists(destdir):
              bb.utils.prunedir(destdir)
+        if not ud.bareclone:
+            ud.unpack_tracer.unpack("git", destdir)
+            ud.checkoutdir = destdir

          need_lfs = self._need_lfs(ud)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index a87361cc..5e3a9947 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -218,6 +218,15 @@ class GitSM(Git):

              try:
                  newfetch = Fetch([url], d, cache=False)
+                # gitsm bareclones submodules into the main repo conf
+                # dir, then leaves the checkout of all submodules
+                # (including nested ones) to an external git command, 
so
+                # it does not need to know submodule checkout dirs;
+                # however such info is needed by unpack tracer API, so
+                # we set it here. This works also for nested 
submodules.
+                if hasattr(ud, "checkoutdir"):
+                    new_ud = newfetch.ud[url]
+                    new_ud.checkoutdir = os.path.join(ud.checkoutdir, 
modpath)
                  
newfetch.unpack(root=os.path.dirname(os.path.join(repo_conf, 'modules', 
module)))
              except Exception as e:
                  logger.error('gitsm: submodule unpack failed: %s %s' % 
(type(e).__name__, str(e)))
diff --git a/lib/bb/fetch2/hg.py b/lib/bb/fetch2/hg.py
index 063e1300..cbff8c49 100644
--- a/lib/bb/fetch2/hg.py
+++ b/lib/bb/fetch2/hg.py
@@ -242,6 +242,7 @@ class Hg(FetchMethod):
          revflag = "-r %s" % ud.revision
          subdir = ud.parm.get("destsuffix", ud.module)
          codir = "%s/%s" % (destdir, subdir)
+        ud.unpack_tracer.unpack("hg", codir)

          scmdata = ud.parm.get("scmdata", "")
          if scmdata != "nokeep":
diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index f83485ad..15f3f19b 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -298,6 +298,7 @@ class Npm(FetchMethod):
          destsuffix = ud.parm.get("destsuffix", "npm")
          destdir = os.path.join(rootdir, destsuffix)
          npm_unpack(ud.localpath, destdir, d)
+        ud.unpack_tracer.unpack("npm", destdir)

      def clean(self, ud, d):
          """Clean any existing full or partial download"""
diff --git a/lib/bb/fetch2/npmsw.py b/lib/bb/fetch2/npmsw.py
index 4ff2c8ff..ff5f8dc7 100644
--- a/lib/bb/fetch2/npmsw.py
+++ b/lib/bb/fetch2/npmsw.py
@@ -191,7 +191,9 @@ class NpmShrinkWrap(FetchMethod):
              else:
                  raise ParameterError("Unsupported dependency: %s" % 
name, ud.url)

+            # name is needed by unpack tracer for module mapping
              ud.deps.append({
+                "name": name,
                  "url": url,
                  "localpath": localpath,
                  "extrapaths": extrapaths,
@@ -270,6 +272,7 @@ class NpmShrinkWrap(FetchMethod):
          destsuffix = ud.parm.get("destsuffix")
          if destsuffix:
              destdir = os.path.join(rootdir, destsuffix)
+        ud.unpack_tracer.unpack("npm-shrinkwrap", destdir)

          bb.utils.mkdirhier(destdir)
          bb.utils.copyfile(ud.shrinkwrap_file,

