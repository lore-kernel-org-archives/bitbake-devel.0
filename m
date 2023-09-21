Return-Path: <alberto@pianon.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763F6E70714
	for <webhook@archiver.kernel.org>; Thu, 21 Sep 2023 10:45:14 +0000 (UTC)
Received: from server3.justice4all.it (server3.justice4all.it [95.217.19.36])
 by mx.groups.io with SMTP id smtpd.web11.13139.1695293104754680321
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 21 Sep 2023 03:45:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pianon.eu header.s=mail20151219 header.b=lgmhR7v2;
 spf=pass (domain: pianon.eu, ip: 95.217.19.36, mailfrom: alberto@pianon.eu)
Received: from localhost (localhost [127.0.0.1])
	by server3.justice4all.it (Postfix) with ESMTP id 0171B5C0096;
	Thu, 21 Sep 2023 12:45:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pianon.eu; h=
	message-id:references:in-reply-to:subject:subject:from:from:date
	:date:content-transfer-encoding:content-type:content-type
	:mime-version; s=mail20151219; t=1695293101; x=1697107502; bh=8V
	m0y0rsiZd7o0YIz8h5lbyDCVog7MdPouoo9K7O6lU=; b=lgmhR7v2E+MLJytBsp
	e0Qjta9gS8bImmip3FJ2XPWyhLsWegiqUM+XQ+OhheGWJMa16m7tlePE6X8I57Z3
	D63E8Qn9xckLY7eX2iHaCnT6eWorbwzAemDC4ChSy+VDn/2f1c6tLpt+aC0GYbV5
	UezEjYHX3sUvHatut6MLoe5l4=
X-Virus-Scanned: Debian amavisd-new at server3.justice4all.it
Received: from server3.justice4all.it ([127.0.0.1])
	by localhost (server3.justice4all.it [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id K1Lhn6jxbA4R; Thu, 21 Sep 2023 12:45:01 +0200 (CEST)
Received: from pianon.eu (localhost [127.0.0.1])
	(Authenticated sender: alberto@pianon.eu)
	by server3.justice4all.it (Postfix) with ESMTPA id 2B9F95C0095;
	Thu, 21 Sep 2023 12:45:01 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 21 Sep 2023 12:45:01 +0200
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
Message-ID: <64f52c05de19446f3fc82a906a3d9377@pianon.eu>
X-Sender: alberto@pianon.eu
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 21 Sep 2023 10:45:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15101

On 2023-09-21 11:00, Richard Purdie wrote:
> On Thu, 2023-09-21 at 08:39 +0200, Alberto Pianon wrote:
>> On 2023-09-20 21:20, Richard Purdie wrote:
>> > On Wed, 2023-09-20 at 21:02 +0200, Alberto Pianon wrote:
>> > > On 2023-09-20 20:39, Richard Purdie wrote:
>> > >
>> > > > > > Again, you'd get the git unpack events for this?
>> > > > >
>> > > > > This method passes git submodule's url, name, relative checkout path
>> > > > > and
>> > > > > revision to the tracer: where do you suggest to collect the same
>> > > > > information? Should the tracer autonomously parse all .gitmodules
>> > > > > files
>> > > > > again and use git commands to reconstruct the same information?
>> > > >
>> > > > No, you shouldn't need to parse those. Isn't this information included
>> > > > in the ud that is being passed to git unpack in the line immediately
>> > > > below? That will be seen via the git unpack call the tracer will see?
>> > > >
>> > > > >
>> > > > > >
>> > > > > > >           Git.unpack(self, ud, destdir, d)
>> > >
>> > > Partly. The missing piece of information is the checkout path. If you
>> > > search for
>> > > 'modpath' in gitsm.py you see that that parameter is passed to
>> > > multiple
>> > > functions but never used (apart from module updates) nor stored
>> > > anywhere
>> > > (or am I missing something?)
>> >
>> > "unpack path" is pretty much the thing you're having to instrument the
>> > other fetchers for so if that is the only extra information being
>> > logged in gitsm, that brings it into line with all the other fetchers
>> > and we have a consistent API.
>> >
>> > What worried me more was an unbalanced API where some fetchers had to
>> > have extra special handling. If the tracer API is consistent with just
>> > the unpack/checkout path needing logging/tracing, that is much clearer
>> > and consistent and a sign the API is right.
>> 
>> Unpack path of git submodules (including nested ones) - stored in
>> ud.destdir -corresponds to their bareclone path (like in
>> <workdir>/git/.git/modules/<parent-module-name>/<module-name>) and not
>> to the checkout path, which is not even calculated by gitsm. The
>> bareclone path is of no use for the tracer, and in any case it's not
>> consistent with what other fetchers return as unpack dir to the tracer
>> (which should be the folder with where unpacked files are found).
>> 
>> IIUC, in case of git submodules (nested or not), gitsm fetcher just
>> bareclones them but it does not check them out; all generated 
>> subodules
>> urls/urldata have the bareclone parameter set and no information about
>> the checkout path; ud.destdir is set to the bareclone path. Only at 
>> the
>> end, when all submodules (including nested ones) have been barecloned,
>> gitsm calls 'git submodule update --recursive --no-fetch' only once, 
>> to
>> check out submodules into <workdir>/git/<module-path>,
>> <workdir>/git/<parent-module-path>/<module-path> etc.
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

OK, let's start with this one, then :)

Does this patch look good to you? Should I submit it separately?

Cheers,

Alberto

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 4385d0b3..1b759bc4 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -193,6 +193,8 @@ class Git(FetchMethod):
          ud.shallow = d.getVar("BB_GIT_SHALLOW") == "1"
          ud.shallow_extra_refs = (d.getVar("BB_GIT_SHALLOW_EXTRA_REFS") 
or "").split()

+        ud.checkout_dir = None
+
          depth_default = d.getVar("BB_GIT_SHALLOW_DEPTH")
          if depth_default is not None:
              try:
@@ -590,6 +592,9 @@ class Git(FetchMethod):
          if os.path.exists(destdir):
              bb.utils.prunedir(destdir)

+        if ud.checkout_dir is None and not ud.bareclone:
+            ud.checkout_dir = destdir
+
          need_lfs = self._need_lfs(ud)

          if not need_lfs:
diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index a87361cc..8a6f91e0 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -218,6 +218,9 @@ class GitSM(Git):

              try:
                  newfetch = Fetch([url], d, cache=False)
+                if ud.checkout_dir is not None:
+                    new_ud = newfetch.ud[url]
+                    new_ud.checkout_dir = os.path.join(ud.checkout_dir, 
modpath)
                  
newfetch.unpack(root=os.path.dirname(os.path.join(repo_conf, 'modules', 
module)))
              except Exception as e:
                  logger.error('gitsm: submodule unpack failed: %s %s' % 
(type(e).__name__, str(e)))


