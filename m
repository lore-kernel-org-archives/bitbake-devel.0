Return-Path: <alberto@pianon.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B8FEDEC69
	for <webhook@archiver.kernel.org>; Wed, 13 Sep 2023 14:33:09 +0000 (UTC)
Received: from server3.justice4all.it (server3.justice4all.it [95.217.19.36])
 by mx.groups.io with SMTP id smtpd.web11.22.1694615582253253156
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Sep 2023 07:33:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pianon.eu header.s=mail20151219 header.b=rdDooDQr;
 spf=pass (domain: pianon.eu, ip: 95.217.19.36, mailfrom: alberto@pianon.eu)
Received: from localhost (localhost [127.0.0.1])
	by server3.justice4all.it (Postfix) with ESMTP id CCAA85C0096;
	Wed, 13 Sep 2023 16:32:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pianon.eu; h=
	message-id:references:in-reply-to:subject:subject:from:from:date
	:date:content-transfer-encoding:content-type:content-type
	:mime-version; s=mail20151219; t=1694615579; x=1696429980; bh=td
	zCbh60/eDMIzb23ArhFlIGsghHQsSRDblv8lF2pxs=; b=rdDooDQrR3JXr94YBA
	Zp+8CQNUdZYFZ+mp2ZQXj5yCIhpp/ABdSlKrjW+u5B6Wn8rt/X/2bePjixHTEFzq
	cSypPBvu27IvkRI0udc8kb9MBoOegAau6LExhSkt9KPhVbeqA0TssPTy0Azwt3aw
	3b5b/ni1SxeCXk3ZZtNZUcnxU=
X-Virus-Scanned: Debian amavisd-new at server3.justice4all.it
Received: from server3.justice4all.it ([127.0.0.1])
	by localhost (server3.justice4all.it [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id QwFfo3D-voWi; Wed, 13 Sep 2023 16:32:59 +0200 (CEST)
Received: from pianon.eu (localhost [127.0.0.1])
	(Authenticated sender: alberto@pianon.eu)
	by server3.justice4all.it (Postfix) with ESMTPA id F36F55C0095;
	Wed, 13 Sep 2023 16:32:58 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 13 Sep 2023 16:32:58 +0200
From: Alberto Pianon <alberto@pianon.eu>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Bitbake Devel <bitbake-devel@lists.openembedded.org>, 'Carlo Piana'
 <carlo@piana.eu>, Joshua Watt <jpewhacker@gmail.com>
Subject: Re: initial idea for hooks needed for source tracing
In-Reply-To: <fa1abc9099171f8fb26c60fd29bc4dfd15376f8a.camel@linuxfoundation.org>
References: <7f5d05fe554d232c300b2604addc452a@pianon.eu>
 <fa1abc9099171f8fb26c60fd29bc4dfd15376f8a.camel@linuxfoundation.org>
Message-ID: <517df01859172566e88a239658c601be@pianon.eu>
X-Sender: alberto@pianon.eu
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 Sep 2023 14:33:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15049

On 2023-09-13 14:12, Richard Purdie wrote:
> On Tue, 2023-09-12 at 22:55 +0200, Alberto Pianon wrote:
>> as I said at today's meeting there is no hurry, but right after the
>> meeting I had an idea and I wanted to fix it in my mind and test it
>> before losing it :)
>> 
>> It's just a temporary/WIP patch, but it should not be too far from a
>> working implementation of the hooks we were talking about:
>> 
>> http://cgit.openembedded.org/bitbake-contrib/commit/?h=alpianon/srctrace4&id=ecb065e7fe2eece566cd387e24abc3b6079146d8
>> 
>> There is no interference nor modification to the unpack process any
>> more, just collection of needed metadata through the urldata object.
>> Modifications to the core unpack function are minimal and (I hope!)
>> straightforward, and there is no fetcher-specific logic in it ant 
>> more.
>> 
>> When you find some time, could you please have a look and tell me if
>> this may be the right direction?
> 
> I think what we should do for now is something like the code below,
> basically to instrument the unpack process but not change it's code.
> 

I thought I had to avoid putting unpack tracing methods in individual
fetchers so I moved them in the core unpack method, but of course
it would be much better to put them into fetchers' code in the "right"
place (i.e. where the unpack actually happens). That would simplify
the logic needed on the backend side, too.

I had tried a similar solution at the beginning; your proposal is much
cleaner though, I'll try to follow it and come back to you.

> 
> This leaves all the "messy" state engine pieces you need to your own
> backend where you can develop them as needed.
> 
> Obviously you'd need to implement something to swap unpack_tracer to
> your own module but that shouldn't be too difficult to do. I don't
> really like globals but for this particular situation, it is probably
> inevitable. I am limiting the use of the global to __init__.py
> deliberately.
> 
> I only converted crate.py as an example but I think this approach
> should work for the other modules too.

gitsm and npmsw are the tricky ones, so let's start with them :)
I will try to implement the same approach there and then ask you
to quickly review it, but I have some questions, see inline in your
patch below

> 
> Some general thoughts on various things:
> 
> * destdir is a problematic name to have in the urldata object as it is
> easily confused with a concept used in do_install tasks. "unpackdir"
> would have been more accurate and less confusing. Obviously it could
> easily be renamed in your patches and it is following naming within the
> fetchers but I think it is better to use a clearer name. Something to
> keep in mind in the tracing code in general.

I reckon I chose destdir just because it was already used in git and
gitsm fectchers, so I added it also to the other fetchers, but actually
it may be confusing, so I will switch to "unpackdir", which is
straightforward

> 
> * I don't like the parameters that were being added to unpack()
> (checkout_destdir and is_module) as their meaning is unclear and appear
> fetcher module specific. The intention of a generic "tracer" module
> pointer is clear.
> 
> * As we discussed, the unpack to a temp location and move into position
> seemed like a good idea but the implementation is too complex
> unfortunately. Sorry to point in the wrong direction on that one.

If we didn't try it, we would never know :)

> 
> * Adding any kind of unpackdir derived directory to urldata in general
> seems like it is a bad idea as it is only valid for the life of the
> unpack() call. When I suggested poking into ud, I had something like
> the patch below in mind where we can use it to help the tracing without
> adding more parameters, instead using function calls.
> 

OK, I just have one doubt about how to handle that in gitsm and npmsw,
that internallly create new Fetch and FetchData (urldata) instances to
recursively call the core unpack method. See inline in your patch below

> * Ultimately we may need to have some basic tracer by default, mainly
> to get a idea of the end result of the fetching. I remain unconvinced
> we need to map every file back to a specific entry in SRC_URI though.
> 
> * Ideally the "unpack_type" parameter to DummyUnpackTracer might not be
> needed, or becomes optional.
> 
> 
> Cheers,
> 
> Richard
> 
> 
> diff --git a/bitbake/lib/bb/fetch2/__init__.py 
> b/bitbake/lib/bb/fetch2/__init__.py
> index 0ead303ca16..2b8de4da10b 100644
> --- a/bitbake/lib/bb/fetch2/__init__.py
> +++ b/bitbake/lib/bb/fetch2/__init__.py
> @@ -139,6 +139,25 @@ class MissingChecksumEvent(bb.event.Event):
>          self.checksums = checksums
>          bb.event.Event.__init__(self)
> 
> +class DummyUnpackTracer(object):
> +
> +    def start(self, unpackdir, urldata, d):
> +        return
> +
> +    def start_url(self, url):
> +        return
> +
> +    def unpack(self, unpack_type, destdir):
> +        return
> +
> +    def finish_url(self, url):
> +        return
> +
> +    def complete(self):
> +        return
> +
> +unpack_tracer = DummyUnpackTracer()
> +
> 
>  class URI(object):
>      """
> @@ -1591,6 +1610,8 @@ class FetchMethod(object):
>                      if urlpath.find("/") != -1:
>                          destdir = urlpath.rsplit("/", 1)[0] + '/'
>                          bb.utils.mkdirhier("%s/%s" % (unpackdir, 
> destdir))
> +
> +                ud.unpack_tracer.unpack("extract", destdir)
>                  cmd = 'cp -fpPRH "%s" "%s"' % (file, destdir)
> 
>          if not cmd:
> @@ -1707,6 +1728,7 @@ class Fetch(object):
>              if url not in self.ud:
>                  try:
>                      self.ud[url] = FetchData(url, d, localonly)
> +                    self.ud.unpack_tracer = unpack_tracer

maybe you mean this? Or am I getting it wrong?

                        self.ud[url].unpack_tracer = unpack_tracer

In any case, Gitsm and npmsw fetchers create internal Fecth and
FetchData (urldata) objects to unpack (sub)modules by recursively
calling the core unpack method, so the unpack_tracer object needs to be
passed through in some way... Did you already think about a clean way
to handle that?

I'm also concerned about npmsw modules, because it may (and it does)
happen that the same module, unpacked from the same url, may get
unpacked more than once into different locations in the same root dir,
because of the way npm works (...). Probably start_url and final_url
methods should take also unpackdir as an argument, what do you think?



>                  except NonLocalMethod:
>                      if localonly:
>                          self.ud[url] = None
> @@ -1882,6 +1904,8 @@ class Fetch(object):
>          if not urls:
>              urls = self.urls
> 
> +        unpack_tracer.start(root, self.ud, self.d)
> +
>          for u in urls:
>              ud = self.ud[u]
>              ud.setup_localpath(self.d)
> @@ -1889,11 +1913,15 @@ class Fetch(object):
>              if ud.lockfile:
>                  lf = bb.utils.lockfile(ud.lockfile)
> 
> +            ud.unpack_tracer.start_url(u)
>              ud.method.unpack(ud, root, self.d)
> +            ud.unpack_tracer.finish_url(u)
> 
>              if ud.lockfile:
>                  bb.utils.unlockfile(lf)
> 
> +        unpack_tracer.complete()
> +
>      def clean(self, urls=None):
>          """
>          Clean files that the fetcher gets or places
> diff --git a/bitbake/lib/bb/fetch2/crate.py 
> b/bitbake/lib/bb/fetch2/crate.py
> index 3310ed00506..7eb89d28429 100644
> --- a/bitbake/lib/bb/fetch2/crate.py
> +++ b/bitbake/lib/bb/fetch2/crate.py
> @@ -100,10 +100,12 @@ class Crate(Wget):
> 
>          bp = d.getVar('BP')
>          if bp == ud.parm.get('name'):
> +            ud.unpack_tracer.unpack("crate-extract", rootdir)
>              cmd = "tar -xz --no-same-owner -f %s" % thefile
>          else:
>              cargo_bitbake = self._cargo_bitbake_path(rootdir)
> 
> +            ud.unpack_tracer.unpack("cargo-extract", cargo_bitbake)
>              cmd = "tar -xz --no-same-owner -f %s -C %s" % (thefile, 
> cargo_bitbake)
> 
>              # ensure we've got these paths made

