Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E43AEDEC4A
	for <webhook@archiver.kernel.org>; Wed, 13 Sep 2023 12:12:45 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web11.10255.1694607161664746342
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Sep 2023 05:12:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=iFztf8RK;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-401da71b7c5so76211275e9.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 13 Sep 2023 05:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1694607160; x=1695211960; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j5cDX1vzxJsLYsdCzAIQyBtNp/jr3ONagDcKwhmok+0=;
        b=iFztf8RKVgV1m63682VffLeuTd/9+AT8R/Xkk0zaXfPXpDaXehnEfkGk5vRdVf8qm0
         wvuTJ9qtX5BFDiI7vfJTho0FAiuE9C0ZmYK9SY7kzZKGVoByVYPRPaTB4y7z4+pD08CH
         bEQ68dsncG4/jqyt2fg6cXFA08QxPWbVUXqQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694607160; x=1695211960;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j5cDX1vzxJsLYsdCzAIQyBtNp/jr3ONagDcKwhmok+0=;
        b=UtgXjbEH+BQI9obOxpM48x67FbpdSWP5CA/12rbu0rAK4hm8s/P10hqodVZGz72xmU
         4BRw3OOoZGAYyMYlrta693ph6n6tzZ9nyCzprtd3JZn8gWi9G976V7fruYg2OrEQmXad
         aNfWCmLGblH1z8Uu8bbZAGwAkcWnvUQsFuO0Waf4VXBOeoh4vqNk7DdQ29OuxNPSEep5
         KOzRfDx3ejXOJ86+UNZIvC9UY8thbWeXwY6hHuMDPxUZXT7Y1Tsl4aGdvDV18dPS44Y1
         PibWNOlR6RuWXNiwIpVJxLR9n4lhyIsRwW1+Gecl5gNGJnGGeHKsBK5gTWmBDYZ2GC+D
         zTOQ==
X-Gm-Message-State: AOJu0Yz17fTFSVGDR15j4P14C1PRndlOcnmXm9FPIAVbiwjEOJYxZC6z
	w/teGOalkHBnWaYbtpYMC5DLOw==
X-Google-Smtp-Source: AGHT+IHzzClHeG79Ojf6f8TKFGhvQgKfvcZ/Ag+7fgUGZm4XsFqBry7tQsDZ8+QlNBUxRDsVcfBkdg==
X-Received: by 2002:a05:600c:ac5:b0:401:d803:624f with SMTP id c5-20020a05600c0ac500b00401d803624fmr1778608wmr.4.1694607159869;
        Wed, 13 Sep 2023 05:12:39 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:2a8:4888:9029:4207? ([2001:8b0:aba:5f3c:2a8:4888:9029:4207])
        by smtp.gmail.com with ESMTPSA id f22-20020a1c6a16000000b003fbe4cecc3bsm1871629wmc.16.2023.09.13.05.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 05:12:39 -0700 (PDT)
Message-ID: <fa1abc9099171f8fb26c60fd29bc4dfd15376f8a.camel@linuxfoundation.org>
Subject: Re: initial idea for hooks needed for source tracing
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alberto Pianon <alberto@pianon.eu>, Bitbake Devel
	 <bitbake-devel@lists.openembedded.org>
Cc: 'Carlo Piana' <carlo@piana.eu>, Joshua Watt <jpewhacker@gmail.com>
Date: Wed, 13 Sep 2023 13:12:38 +0100
In-Reply-To: <7f5d05fe554d232c300b2604addc452a@pianon.eu>
References: <7f5d05fe554d232c300b2604addc452a@pianon.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 Sep 2023 12:12:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15047

On Tue, 2023-09-12 at 22:55 +0200, Alberto Pianon wrote:
> as I said at today's meeting there is no hurry, but right after the=20
> meeting I had an idea and I wanted to fix it in my mind and test it=20
> before losing it :)
>=20
> It's just a temporary/WIP patch, but it should not be too far from a=20
> working implementation of the hooks we were talking about:
>=20
> http://cgit.openembedded.org/bitbake-contrib/commit/?h=3Dalpianon/srctrac=
e4&id=3Decb065e7fe2eece566cd387e24abc3b6079146d8
>=20
> There is no interference nor modification to the unpack process any=20
> more, just collection of needed metadata through the urldata object.
> Modifications to the core unpack function are minimal and (I hope!)=20
> straightforward, and there is no fetcher-specific logic in it ant more.
>=20
> When you find some time, could you please have a look and tell me if=20
> this may be the right direction?

I think what we should do for now is something like the code below,
basically to instrument the unpack process but not change it's code.

This leaves all the "messy" state engine pieces you need to your own
backend where you can develop them as needed.

Obviously you'd need to implement something to swap unpack_tracer to
your own module but that shouldn't be too difficult to do. I don't
really like globals but for this particular situation, it is probably
inevitable. I am limiting the use of the global to __init__.py
deliberately.

I only converted crate.py as an example but I think this approach
should work for the other modules too.

Some general thoughts on various things:

* destdir is a problematic name to have in the urldata object as it is
easily confused with a concept used in do_install tasks. "unpackdir"
would have been more accurate and less confusing. Obviously it could
easily be renamed in your patches and it is following naming within the
fetchers but I think it is better to use a clearer name. Something to
keep in mind in the tracing code in general.

* I don't like the parameters that were being added to unpack()
(checkout_destdir and is_module) as their meaning is unclear and appear
fetcher module specific. The intention of a generic "tracer" module
pointer is clear.

* As we discussed, the unpack to a temp location and move into position
seemed like a good idea but the implementation is too complex
unfortunately. Sorry to point in the wrong direction on that one.

* Adding any kind of unpackdir derived directory to urldata in general
seems like it is a bad idea as it is only valid for the life of the
unpack() call. When I suggested poking into ud, I had something like
the patch below in mind where we can use it to help the tracing without
adding more parameters, instead using function calls.

* Ultimately we may need to have some basic tracer by default, mainly
to get a idea of the end result of the fetching. I remain unconvinced
we need to map every file back to a specific entry in SRC_URI though.

* Ideally the "unpack_type" parameter to DummyUnpackTracer might not be
needed, or becomes optional.


Cheers,

Richard


diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__in=
it__.py
index 0ead303ca16..2b8de4da10b 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -139,6 +139,25 @@ class MissingChecksumEvent(bb.event.Event):
         self.checksums =3D checksums
         bb.event.Event.__init__(self)
=20
+class DummyUnpackTracer(object):
+
+    def start(self, unpackdir, urldata, d):
+        return
+
+    def start_url(self, url):
+        return
+
+    def unpack(self, unpack_type, destdir):
+        return
+
+    def finish_url(self, url):
+        return
+
+    def complete(self):
+        return
+
+unpack_tracer =3D DummyUnpackTracer()
+
=20
 class URI(object):
     """
@@ -1591,6 +1610,8 @@ class FetchMethod(object):
                     if urlpath.find("/") !=3D -1:
                         destdir =3D urlpath.rsplit("/", 1)[0] + '/'
                         bb.utils.mkdirhier("%s/%s" % (unpackdir, destdir))
+
+                ud.unpack_tracer.unpack("extract", destdir)
                 cmd =3D 'cp -fpPRH "%s" "%s"' % (file, destdir)
=20
         if not cmd:
@@ -1707,6 +1728,7 @@ class Fetch(object):
             if url not in self.ud:
                 try:
                     self.ud[url] =3D FetchData(url, d, localonly)
+                    self.ud.unpack_tracer =3D unpack_tracer
                 except NonLocalMethod:
                     if localonly:
                         self.ud[url] =3D None
@@ -1882,6 +1904,8 @@ class Fetch(object):
         if not urls:
             urls =3D self.urls
=20
+        unpack_tracer.start(root, self.ud, self.d)
+
         for u in urls:
             ud =3D self.ud[u]
             ud.setup_localpath(self.d)
@@ -1889,11 +1913,15 @@ class Fetch(object):
             if ud.lockfile:
                 lf =3D bb.utils.lockfile(ud.lockfile)
=20
+            ud.unpack_tracer.start_url(u)
             ud.method.unpack(ud, root, self.d)
+            ud.unpack_tracer.finish_url(u)
=20
             if ud.lockfile:
                 bb.utils.unlockfile(lf)
=20
+        unpack_tracer.complete()
+
     def clean(self, urls=3DNone):
         """
         Clean files that the fetcher gets or places
diff --git a/bitbake/lib/bb/fetch2/crate.py b/bitbake/lib/bb/fetch2/crate.p=
y
index 3310ed00506..7eb89d28429 100644
--- a/bitbake/lib/bb/fetch2/crate.py
+++ b/bitbake/lib/bb/fetch2/crate.py
@@ -100,10 +100,12 @@ class Crate(Wget):
=20
         bp =3D d.getVar('BP')
         if bp =3D=3D ud.parm.get('name'):
+            ud.unpack_tracer.unpack("crate-extract", rootdir)
             cmd =3D "tar -xz --no-same-owner -f %s" % thefile
         else:
             cargo_bitbake =3D self._cargo_bitbake_path(rootdir)
=20
+            ud.unpack_tracer.unpack("cargo-extract", cargo_bitbake)
             cmd =3D "tar -xz --no-same-owner -f %s -C %s" % (thefile, carg=
o_bitbake)
=20
             # ensure we've got these paths made

