Return-Path: <alberto@pianon.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F0DC04FCE
	for <webhook@archiver.kernel.org>; Wed, 20 Sep 2023 18:10:39 +0000 (UTC)
Received: from server3.justice4all.it (server3.justice4all.it [95.217.19.36])
 by mx.groups.io with SMTP id smtpd.web11.2586.1695233429445347124
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Sep 2023 11:10:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pianon.eu header.s=mail20151219 header.b=BYLMWeK1;
 spf=pass (domain: pianon.eu, ip: 95.217.19.36, mailfrom: alberto@pianon.eu)
Received: from localhost (localhost [127.0.0.1])
	by server3.justice4all.it (Postfix) with ESMTP id 14E145C0096;
	Wed, 20 Sep 2023 20:10:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pianon.eu; h=
	message-id:references:in-reply-to:subject:subject:from:from:date
	:date:content-transfer-encoding:content-type:content-type
	:mime-version; s=mail20151219; t=1695233426; x=1697047827; bh=cc
	6LkjlMbNfCx+iA7WBfuA/hWXqriBfEC1kEP6Osf/s=; b=BYLMWeK1zral/DWZSr
	6JpPvm6dcjDVv7nVycr35eszes08W6ASvvTWmhBCoHggicJ/rZ/Cr6LSOZyjdJn1
	haXSHfKky8d9AQZUiWysPdzsakU3No+tkPe84SC7gVLFB/hdSpKttL4+kqyLIPFa
	He7J5PpW7RWKO4yru9fn50UjY=
X-Virus-Scanned: Debian amavisd-new at server3.justice4all.it
Received: from server3.justice4all.it ([127.0.0.1])
	by localhost (server3.justice4all.it [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id y5eUUxJI10j0; Wed, 20 Sep 2023 20:10:26 +0200 (CEST)
Received: from pianon.eu (localhost [127.0.0.1])
	(Authenticated sender: alberto@pianon.eu)
	by server3.justice4all.it (Postfix) with ESMTPA id 144BF5C0095;
	Wed, 20 Sep 2023 20:10:26 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 20 Sep 2023 20:10:26 +0200
From: Alberto Pianon <alberto@pianon.eu>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Bitbake Devel <bitbake-devel@lists.openembedded.org>, 'Carlo Piana'
 <carlo@piana.eu>, Joshua Watt <jpewhacker@gmail.com>
Subject: Re: initial idea for hooks needed for source tracing
In-Reply-To: <8a899d6d88c1d493d48c3a495a9671b13df6a408.camel@linuxfoundation.org>
References: <7f5d05fe554d232c300b2604addc452a@pianon.eu>
 <fa1abc9099171f8fb26c60fd29bc4dfd15376f8a.camel@linuxfoundation.org>
 <517df01859172566e88a239658c601be@pianon.eu>
 <bda639e462aa9f7bfd4a04e17d953e23b99ca2b0.camel@linuxfoundation.org>
 <6d0c953729ea7602ee09cc9238513c1b@pianon.eu>
 <8a899d6d88c1d493d48c3a495a9671b13df6a408.camel@linuxfoundation.org>
Message-ID: <15196a1c207f89bfc8894f155b05cbde@pianon.eu>
X-Sender: alberto@pianon.eu
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 20 Sep 2023 18:10:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15092

thanks for the instant response!
my comments inline below

Cheers,

Alberto

On 2023-09-20 17:58, Richard Purdie wrote:
> Hi Alberto,
> 
> On Wed, 2023-09-20 at 17:32 +0200, Alberto Pianon wrote:
>> I started playing a little bit with a possible implementation handling
>> also gitsm and npmsw fetchers, and I came up with the draft below, 
>> based
>> on your proposal (the draft does not include the implementation, just
>> the API).
> 
> I'll comment below. Your code was line wrapped so it isn't entirely
> pretty but i've tried to clean it up a bit in my reply to make it
> readable.
> 
>> I'm not sure that all arguments are needed, but this is roughly how 
>> the
>> API should look alike. Before I go on with the implementation, could 
>> you
>> please tell me if this time we are on the right track?
> 
> I would like to reduce some of the arguments being passed around if we
> can.

of course. First I need to have a working PoC of the implementation 
(even
if it will not be included in the patch) to be 100% sure of what is
strictly needed and what is not

> 
>> Moreover, do you have any idea on how and where we may dynamically 
>> load
>> the user defined class instead of the dummy one, based on some config
>> parameter, like 'TRACER_UNPACKCLASS == "mytrace.unpack.UnpackTracer"?
> 
> I don't have anything offhand, I'd have to experiment with some code to
> come up with something. I can try and find some time to do so but that
> problem is definitely one we can solve as we do this elsewhere.
> 
> 
>> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
>> index 765aedd5..a8b44a4f 100644
>> --- a/lib/bb/fetch2/__init__.py
>> +++ b/lib/bb/fetch2/__init__.py
>> @@ -140,6 +140,35 @@ class MissingChecksumEvent(bb.event.Event):
>>           bb.event.Event.__init__(self)
>> 
>> 
>> +class DummyUnpackTracer(object):
>> +
>> +    def start(self, unpackdir, ud_dict, d):
>> +        return
>> +
>> +    def start_url(self, url):
>> +        return
>> +
>> +    def unpack(self, unpack_type, destdir, ud=None):
>> +        return
>> +
>> +    def finish_url(self, url):
>> +        return
>> +
>> +    def start_module(self, module_type, unpackdir, ud_dict, 
>> parent_ud, d):
>> +        return
>> +
>> +    def module(self, module_type, url, name, path, revision=None):
>> +        return
>> +
>> +    def finish_module(self, module_type, unpackdir, ud_dict, 
>> parent_ud, d):
>> +        return
>> +
>> +    def complete(self):
>> +        return
>> +
>> +unpack_tracer = DummyUnpackTracer()
>> +
>> +
>>   class URI(object):
>>       """
>>       A class representing a generic URI, with methods for
>> @@ -1578,6 +1607,7 @@ class FetchMethod(object):
>>               unpackdir = rootdir
>> 
>>           if not unpack or not cmd:
>> +            urldata.unpack_tracer.unpack("file-copy", unpackdir)
>>               # If file == dest, then avoid any copies, as we already 
>> put the file into dest!
>>               dest = os.path.join(unpackdir, os.path.basename(file))
>>               if file != dest and not (os.path.exists(dest) and 
>> os.path.samefile(file, dest)):
>> @@ -1591,8 +1621,13 @@ class FetchMethod(object):
>>                       if urlpath.find("/") != -1:
>>                           destdir = urlpath.rsplit("/", 1)[0] + '/'
>>                           bb.utils.mkdirhier("%s/%s" % (unpackdir, 
>> destdir))
>> +                        urldata.unpack_tracer.unpack(
>> +                            "file-copy", "%s/%s" % (unpackdir, 
>> destdir))
> 
> I'm not too happy about having two different "file-copy" callbacks with
> different return values. Either you need the two endpoints or the
> initial one but do you really need both?

The information that I need here is that a file named, say, 'hello',
whose url is 'file://examples/hello' and whose path in the corresponding
upstream repo is something like 'meta/foo/examples/hello', gets
copied/unpacked into '<workdir>/examples/' ("%s/%s" % (unpackdir,
destdir)). I may get rid of the second "file-copy" callback above and
reconstruct the same information ex post, but this would require an
assumption on how this kind of urls are handled by bitbake. If this
won't reasonably change in the future, I can assume it and delete the
callback :)


> 
>>                   cmd = 'cp -fpPRH "%s" "%s"' % (file, destdir)
>> 
>> +        else:
>> +            urldata.unpack_tracer.unpack("archive-extract", 
>> unpackdir)
>> +
>>           if not cmd:
>>               return
>> 
>> @@ -1707,6 +1742,7 @@ class Fetch(object):
>>               if url not in self.ud:
>>                   try:
>>                       self.ud[url] = FetchData(url, d, localonly)
>> +                    self.ud[url].unpack_tracer = unpack_tracer
>>                   except NonLocalMethod:
>>                       if localonly:
>>                           self.ud[url] = None
>> @@ -1882,6 +1918,8 @@ class Fetch(object):
>>           if not urls:
>>               urls = self.urls
>> 
>> +        unpack_tracer.start(root, self.ud, self.d)
>> +
>>           for u in urls:
>>               ud = self.ud[u]
>>               ud.setup_localpath(self.d)
>> @@ -1889,11 +1927,15 @@ class Fetch(object):
>>               if ud.lockfile:
>>                   lf = bb.utils.lockfile(ud.lockfile)
>> 
>> +            unpack_tracer.start_url(u)
>>               ud.method.unpack(ud, root, self.d)
>> +            unpack_tracer.finish_url(u)
>> 
>>               if ud.lockfile:
>>                   bb.utils.unlockfile(lf)
>> 
>> +        unpack_tracer.complete()
>> +
>>       def clean(self, urls=None):
>>           """
>>           Clean files that the fetcher gets or places
>> diff --git a/lib/bb/fetch2/crate.py b/lib/bb/fetch2/crate.py
>> index 3310ed00..01d49435 100644
>> --- a/lib/bb/fetch2/crate.py
>> +++ b/lib/bb/fetch2/crate.py
>> @@ -101,8 +101,10 @@ class Crate(Wget):
>>           bp = d.getVar('BP')
>>           if bp == ud.parm.get('name'):
>>               cmd = "tar -xz --no-same-owner -f %s" % thefile
>> +            ud.unpack_tracer.unpack("crate-extract", rootdir)
>>           else:
>>               cargo_bitbake = self._cargo_bitbake_path(rootdir)
>> +            ud.unpack_tracer.unpack("cargo-extract", cargo_bitbake)
>> 
>>               cmd = "tar -xz --no-same-owner -f %s -C %s" % (thefile,
>> cargo_bitbake)
>> 
>> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
>> index 4385d0b3..567943da 100644
>> --- a/lib/bb/fetch2/git.py
>> +++ b/lib/bb/fetch2/git.py
>> @@ -589,6 +589,7 @@ class Git(FetchMethod):
>>           destdir = ud.destdir = os.path.join(destdir, destsuffix)
>>           if os.path.exists(destdir):
>>               bb.utils.prunedir(destdir)
>> +        ud.unpack_tracer.unpack("git", destdir, ud)
>> 
>>           need_lfs = self._need_lfs(ud)
>> 
>> diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
>> index a87361cc..06dda48b 100644
>> --- a/lib/bb/fetch2/gitsm.py
>> +++ b/lib/bb/fetch2/gitsm.py
>> @@ -218,7 +218,9 @@ class GitSM(Git):
>> 
>>               try:
>>                   newfetch = Fetch([url], d, cache=False)
>> +                ud.unpack_tracer.start_module("git", repo_conf, 
>> newfetch.ud, ud, d)
>>                   
>> newfetch.unpack(root=os.path.dirname(os.path.join(repo_conf, 
>> 'modules', module)))
>> +                ud.unpack_tracer.finish_module("git", repo_conf, 
>> newfetch.ud, ud, d)
> 
> I don't understand the need for this piece since you'd get start/finish
> events from the tracer here for the newfetch object?

start_module is actually like a 'pre-start' method, aimed at telling the
"nested" start method that will be invoked inside newfetch.unpack that
we are processing a submodule and not the main repo (and also at
calculating the checkout dir for nested git submodules, which is not
known to gitsm).
The alternative would be to add parameters to the core unpack method,
but you don't want that :)
I don't have other ideas, what do you think about it?

As to finish_module. it should aggregate nested submodules data.
I'm not sure it's strictly needed, though: I have to develop a working
PoC of the implementation to see if data may be aggregated in another
place.

> 
> 
>>               except Exception as e:
>>                   logger.error('gitsm: submodule unpack failed: %s %s' 
>> % (type(e).__name__, str(e)))
>>                   raise
>> @@ -238,6 +240,8 @@ class GitSM(Git):
>>                   logger.error("Unable to set git config core.bare to 
>> false for %s" % os.path.join(repo_conf, 'modules', module))
>>                   raise
>> 
>> +            ud.unpack_tracer.module("git", url, module, modpath, 
>> d.getVar("SRCREV_%s" % module))
>> +
> 
> Again, you'd get the git unpack events for this?

This method passes git submodule's url, name, relative checkout path and 
revision to the tracer: where do you suggest to collect the same 
information? Should the tracer autonomously parse all .gitmodules files 
again and use git commands to reconstruct the same information?

> 
>>           Git.unpack(self, ud, destdir, d)
>> 
>>           ret = self.process_submodules(ud, ud.destdir,
>> unpack_submodules, d)
>> diff --git a/lib/bb/fetch2/hg.py b/lib/bb/fetch2/hg.py
>> index 063e1300..cbff8c49 100644
>> --- a/lib/bb/fetch2/hg.py
>> +++ b/lib/bb/fetch2/hg.py
>> @@ -242,6 +242,7 @@ class Hg(FetchMethod):
>>           revflag = "-r %s" % ud.revision
>>           subdir = ud.parm.get("destsuffix", ud.module)
>>           codir = "%s/%s" % (destdir, subdir)
>> +        ud.unpack_tracer.unpack("hg", codir)
>> 
>>           scmdata = ud.parm.get("scmdata", "")
>>           if scmdata != "nokeep":
>> diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
>> index f83485ad..15f3f19b 100644
>> --- a/lib/bb/fetch2/npm.py
>> +++ b/lib/bb/fetch2/npm.py
>> @@ -298,6 +298,7 @@ class Npm(FetchMethod):
>>           destsuffix = ud.parm.get("destsuffix", "npm")
>>           destdir = os.path.join(rootdir, destsuffix)
>>           npm_unpack(ud.localpath, destdir, d)
>> +        ud.unpack_tracer.unpack("npm", destdir)
>> 
>>       def clean(self, ud, d):
>>           """Clean any existing full or partial download"""
>> diff --git a/lib/bb/fetch2/npmsw.py b/lib/bb/fetch2/npmsw.py
>> index 4ff2c8ff..5cab96c4 100644
>> --- a/lib/bb/fetch2/npmsw.py
>> +++ b/lib/bb/fetch2/npmsw.py
>> @@ -192,6 +192,7 @@ class NpmShrinkWrap(FetchMethod):
>>                   raise ParameterError("Unsupported dependency: %s" %
>> name, ud.url)
>> 
>>               ud.deps.append({
>> +                "name": name,
>>                   "url": url,
>>                   "localpath": localpath,
>>                   "extrapaths": extrapaths,
>> @@ -270,16 +271,27 @@ class NpmShrinkWrap(FetchMethod):
>>           destsuffix = ud.parm.get("destsuffix")
>>           if destsuffix:
>>               destdir = os.path.join(rootdir, destsuffix)
>> +        ud.unpack_tracer.unpack("npmsw", destdir)
>> 
>>           bb.utils.mkdirhier(destdir)
>>           bb.utils.copyfile(ud.shrinkwrap_file,
>>                             os.path.join(destdir, 
>> "npm-shrinkwrap.json"))
>> 
>> +        for dep in ud.deps:
>> +            ud.unpack_tracer.module(
>> +                "npm",
>> +                dep["url"] or dep["localpath"],
>> +                dep["name"],
>> +                dep["destsuffix"]
>> +            )
>> +
>>           auto = [dep["url"] for dep in ud.deps if not 
>> dep["localpath"]]
>>           manual = [dep for dep in ud.deps if dep["localpath"]]
>> 
>>           if auto:
>> +            ud.unpack_tracer.start_module("npm", destdir, 
>> ud.proxy.ud,
>> ud, d)
>>               ud.proxy.unpack(destdir, auto)
>> +            ud.unpack_tracer.finish_module("npm", destdir, 
>> ud.proxy.ud,
>> ud, d)
> 
> Don't you get the information from the inner fetch so we no longer need
> this markup here?

How? As in gitsm, 'module' method passes npm module url, name and
relative destination path to the tracer. Do you suggest that the tracer
should autonomously parse the npm-shrinkwrap.json file again, to
get the same information?

'start_module' here is needed for the same reason as in gitsm (avoiding
adding and is_module parameter to the core unpack method)

> 
>> 
>>           for dep in manual:
>>               depdestdir = os.path.join(destdir, dep["destsuffix"])
>> 
> 
> It does feel like either you're misunderstanding the intent of why I
> suggested some of the higher level intercept calls as they should
> reduce the need for the internal module additions, or I'm missing some
> key detail of why those outer tracepoints can't handle everything you
> need :/.

I can reduce internal module additions by externally
recalculating/re-collecting npm/git module information, even if this 
will
cause the same data/files to be processed twice.
If you tell me, I'll do that :)
Do you have any other solution in mind?

Cheers,

Alberto

