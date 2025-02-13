Return-Path: <bruce.ashfield@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0DCC021A4
	for <webhook@archiver.kernel.org>; Thu, 13 Feb 2025 17:01:26 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.web10.1275.1739466079435263791
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Feb 2025 09:01:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=PVzVlhQv;
 spf=pass (domain: gmail.com, ip: 209.85.216.50, mailfrom: bruce.ashfield@gmail.com)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fc0bd358ccso2329119a91.2;
        Thu, 13 Feb 2025 09:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739466079; x=1740070879; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oBwJdwr+/FJdt1yn6rbrxtwYHYDiScSK17nLxAnODsc=;
        b=PVzVlhQvCNsFXWNPZu+wBs9IMTAi7gTJT1nKiHJBcFKI4tRlTKHvjf+4hBTu77yKeF
         UqPKsm9K9HUzMP5S6xM9HcynN8BTEItXqdfO2jq6S9WuNrRuWBbSSXwhXUedSJBaFxZd
         wPFIP0COKqjm33HpQtgqJZ0n/sUuQ4hh3kp3EewOYGI4cskLOz1kjRCvwPZwm5vbA3cB
         4WwMbMgZH78Zd/eKiNgAvH2QY8MZMx/uwsTw9AqakrHKQARoddUYs+2gaHgnnSahw8aN
         61ZSWdkMV/3ckuIsT90Vv/T17JNTzKNaiB+VlWE5R7lRdoj5PaFwJDrgQxrw51KCi853
         R62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739466079; x=1740070879;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oBwJdwr+/FJdt1yn6rbrxtwYHYDiScSK17nLxAnODsc=;
        b=nxodFsN1ICo0CR5GySEaiuGAUr/E0z2+NtwmWvXGeuhKzWNMyPmp8gcq+pqGN2/vg3
         PnJY7kR3gv8g5pwNKVqxy0Gj18XnqNjulmOyJCOk8bQt6ce0NR6ypCk1KoezO2NI7mUR
         9uROQgMgChinlkTbyEct0mELJeh0irhf1ZBhfVYvJoPLQ3om7exyzdPG2luD8Wm/Vqxg
         vmDBsn40odzy0xiwpnUbaiULh8PKajXfpwRpj+tWGx4236l9kiT+OdGjbS6YNxCEEsDr
         ptmMmGYuQRTTKSH9Q5HIsWcmuwDMBrNrROkUtQ6/sxbQpqa659D3xmCPzJ9duETT3vIi
         Feqw==
X-Forwarded-Encrypted: i=1; AJvYcCXmbX/Njh8+5njJ8rgp13B9bYxhBx8jqaljDmaejm3yLYj1yxXoQT96b9f2DV8g9kCT/GBKbRu8Bd1vzIOk@lists.openembedded.org
X-Gm-Message-State: AOJu0YzPWrodEyeVciR9+mgZCBIQWa21BwYxYzRpBydN446QxwA2E+xH
	MwZCmIfQy952CbPB15N+KJTQW/IACjLFuVnW7VjOFxwmKHA4kFxtBTQul1qGsKvr1z7MjEI1rxx
	a9jgIOCew2WDRN0veBkIx01F5qaU=
X-Gm-Gg: ASbGncurtKiLWLKDRxrsD44j7RQjoxdvw+BomFp0kaTr4vvpARxe0OAE3/5t86Xq2TR
	SiGeW85Lq6hYuJ5A0Tptaq/YM4rITRNoKZp75sr/Qn6eYF8XIUEWBiklC1XvLp8DIerquEXYB
X-Google-Smtp-Source: AGHT+IGPODpuGCbm0W1/M9BVDhKQxPXUnMWj1gT8apkr4U4YrPVlh2/pusPzGUZIutruKyUQ72M4laYyiOsqv2ebAFQ=
X-Received: by 2002:a17:90b:3c48:b0:2fa:2252:f43c with SMTP id
 98e67ed59e1d1-2fc0f0f37bemr4765573a91.34.1739466078459; Thu, 13 Feb 2025
 09:01:18 -0800 (PST)
MIME-Version: 1.0
References: <20250211150034.18696-1-stefan.herbrechtsmeier-oss@weidmueller.com>
 <Z6vZ8m8zZLgQKyVg@gmail.com> <40f8d1d9-5bd3-4ac6-a107-32482d06d17b@weidmueller.com>
 <CADkTA4OA8VkQk=FVD=hMDaH+TU2567zLduVfYHSqkR_C4fpjOw@mail.gmail.com> <dc6263e6-e359-49b8-82be-9ca48627c37a@weidmueller.com>
In-Reply-To: <dc6263e6-e359-49b8-82be-9ca48627c37a@weidmueller.com>
From: Bruce Ashfield <bruce.ashfield@gmail.com>
Date: Thu, 13 Feb 2025 12:01:06 -0500
X-Gm-Features: AWEUYZmmbqY_QJJp-Tdh9UF7RVY2MLmEh45ixRYWKBSVLZu4n1Exk8HaUTu73bE
Message-ID: <CADkTA4P+yHsWjRS7zDtBggbe_TXX0NTV0abtTPiLtTDHZeCh7g@mail.gmail.com>
Subject: Re: [bitbake-devel] [RFC PATCH 00/30] Add vendor support for go, npm
 and rust
To: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
Cc: openembedded-core@lists.openembedded.org, 
	Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>, 
	bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000b49f83062e090143"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 13 Feb 2025 17:01:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17217

--000000000000b49f83062e090143
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 3:36=E2=80=AFAM Stefan Herbrechtsmeier <
stefan.herbrechtsmeier-oss@weidmueller.com> wrote:

> Am 12.02.2025 um 15:11 schrieb Bruce Ashfield:
>
>
>
> On Wed, Feb 12, 2025 at 3:41=E2=80=AFAM Stefan Herbrechtsmeier <
> stefan.herbrechtsmeier-oss@weidmueller.com> wrote:
>
>> Am 12.02.2025 um 00:14 schrieb Bruce Ashfield via lists.openembedded.org=
:
>>
>> In message: [bitbake-devel] [RFC PATCH 00/30] Add vendor support for go,=
 npm and rust
>> on 11/02/2025 Stefan Herbrechtsmeier via lists.openembedded.org wrote:
>>
>>
>> From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com> <s=
tefan.herbrechtsmeier@weidmueller.com>
>>
>> The series adds on-the-fly support for package manager specific
>> dependencies and vendor directories. It contains the following changes:
>> 1. Adds an early fetch, unpack and patch task to unpack and patch source
>>    code with an embedded lock file for dependencies.
>> 2. Parse the go.sum, Cargo.lock and package-lock.json lock files and
>>    resolve the dependencies to SRC_URIs.
>> 3. Save the SRC_URIs in a file and adapt all SRC_URIs users to handle
>>    the SRC_URI files beside the SRC_URIs in the recipe.
>>
>> I made a few comments, and will have another / better look at the
>> series tomorrow. There's a lot here, and it is hard to wrap my head
>> around everything that is changing.
>>
>> I have one specific question below (from the point of view of go).
>>
>> I've been looking through the series, and can't pick out where #3 is
>> done.
>>
>> The files are created in the package manager specific vendor classes (17
>> - 19) in the do_vendor_resolve task. The parsing is implemented in the
>> package manager specific modules in the vendor package (6-8).
>>
>>
> aha. I'll have a closer look in a bit!
>
>
>
>>  I see patch 14 using SRC_URI_FILES, but where are those files
>> written ? Is that in patch 18 (vendor_go_do_vendor_resolve ?)  What is
>> written to those files ?
>>
>> The file is written into the vendor directory below WORKDIR. The approac=
h
>> is similar to other classes which need to share data between tasks.
>>
>> The files contain individual SRC_URIs per line.
>>
> I may have missed that in the patches, but if that isn't described in the
> commit logs, then
> that description would be a nice addition. Along with a high level
> description for each
> supported language package manager about what is in the files and what
> uses it to
> resolve the dependencies.
>
> I will extend the commit messages.
>
>
>> The concept that I'm not understanding (and that's just me not being
>> familiar with things, I'll continue reading the series) is that when
>> we suggested we'd like to have a mode where the dependencies could
>> clearly be listed in the SRC_URI, at least I was just thinking about a
>> way run the fetch/module elements that you were adding, write them to
>> a file and then have the recipe include it.
>>
>> The additional SRC_URIs are dynamically added to the recipe without the
>> indirection over an include file. The generated SRC_URIs could be inspec=
ted
>> via the SRC_URI_FILES and manipulated via patches for the lock files or =
an
>> separated lock file.
>>
> The issue with patching those dynamic files .. is just that, they are
> dynamic and
> they could be regenerated (but hopefully without a SRCREV change they are
> identically
> generated each time, so maybe it isn't a big deal) and patching could
> fail. Much like we
> don't patch generated automake files, we patch the .am and .in files that
> generate the
> outputs.
>
> You can't compare lock files with automake files. The lock files is
> generated but it contains additional information. The only difference is
> that a program and not a human write the file. If an update creates too
> much noise in the file we should discuss with upstream how to minimize it=
.
> The lock file is designed to be under revision control and shouldn't chan=
ge
> without reason. Dependabot automatically creates updates and pull request=
s
> for dependency updates. This will not work if the lock file isn't
> deterministic.
>

I may be using different terminology, but I do know what the lock files are
(I interchange the dependency and lock files at times though), patching
*anything* that is generated is a bad idea, that's my point (so the
comparison is valid).


>
>> I can't tell if in the series those files are written each time, and
>> that there would be no way to edit those SRC_URI_FILES .. but I'll
>> look again tomorrow.
>>
>> The files are written if the do_vendor_resolve task need to be rerun. It
>> isn't possible to edit the generated SRC_URIs. Instead the lock file cou=
ld
>> be patched.
>>
>
> ok. So they are really just a way to dump what is being built to disk and
> out of "memory",
> it really isn't what I was looking for, but at least I understand what yo=
u
> were trying to
> do with the writing and later use of the files now.
>
> I was hoping for something that I could include "statically" (for lack of
> a better term) in my
> recipes, and then have the handlers for the protocols do the fetching ..
> again, much like
> the crate:// fetches in the .inc files.
>
> I don't use the fetcher because of its drawbacks and limitations. I use
> the same wget URL without the indirection over the package manager specif=
ic
> fetchers. I can follow the pypi approach to generate SRC_URIs which call =
a
> python function:
>
Can you elaborate on the limitations ?

 Although from your description, I'm fine calling wget a "fetcher". I'm
just talking about something that pulls in the dependency source code,
whether it be git, wget, or some other protocol, it's the concept that is
the same.

> ${@crate_src_uri(d, 'xyz', '1.2.3')}
>
> But why you need this? In any case the manipulation of a dependency could
> lead to interdependence between dependencies.\
>

Because I need to redirect and update them manually. Anything that runs in
python to determine the fetch is also hard to debug, since I'd be
interested in the output of that processing if there's an issue.

I'm describing something like (and I'm describing it badly .. but I'll try
anyway:

 <language file that describes the dependencies>
 <process that file into a specific source  revision and fetch/download
location>
 <have a language / protocol specific fetcher get the modules / source code
iteratively from a list of expanded dependencies>
 <put them into place for the build>
 <arrange for the build to use those fetched depdendencies>

wget would fall into that "language specific fetcher", as would git or "go
vendor" (Although I don't really like that, since it isn't transparent
where the source code is being pulled from).  Copying the files into
vendor, or again "go mod vendor" (doing both the fetch and placement) would
be the "put them in place for the build".

I realize that is what your series is doing.

The processing, fetching, placement  stages could run fully behind the
scenes from a dependency/lock file, or be skipped if broken out into the
list of fetches (from the SCR_URI (via .inc file or whatever)). Those are
the two modes I'm describing, where the "processing the file into a
specific source revision / fetch steps" can be avoided.



>
>
> To be clear, I'm not suggesting that mode would be the only mode, just
> that the way the
> generation of the fetches -> actual fetching was constructed such that I
> could avoid
> "short circuit" the handling of the lock file and simply list the
> dependencies for fetching
> (much like how I can go get all of the SRCREVS for a gitsm:// fetch, and
> put them into
> my recipes as pure git:// fetches if I'm having issues with the git
> submodles).
>
> Add a function to create this file isn't a problem, but I can't ensure
> that this will work in any case and doesn't create problems because of th=
e
> discrepancy between the manifest / lock file and the available sources.
>

Right, and that is fine. If someone bumps a revision to the point where the
dependency now has different dependencies that are not in the lock file,
then they've taken things fully into their control and need to deal with
any issues.  That obviously isn't the default, but does allow an advanced
user/developer the possibility to have fine grained control and debug.


>
> That file would manipulate the standard SRC_URI. In other words still
>> support a mode that is like the .inc files with crate://. So someone
>> could either have the lockfile parsed and fetched, or have a way to
>> run the parsing and fetching via a task, write a file and include the
>> file in their recipe to short circuit the processing of the lockfile.
>> (meaning the expanded and end fetches that are done once you've
>> processed the file are simply listed as a series of fetches that are
>> carried out without extra processing .. and "unrolled" dependency
>> file pointing at the "sources" git, crate, mod, whatever)
>>
>> What is the motivation "to short circuit the processing of the lockfile"=
?
>> Like any task the processing and its output are cached via the sstate ca=
che.
>>
>
> See above. It isn't about re-running it a later time and re-using the
> artifacts, it is about
> having a way to make sure nothing is dynamically resolved when bitbake
> <foo> is called,
> just fetch and the rest of the standard tasks.
>
> The resolve always create the same URL like the crate fetcher. It only
> changes if you change the resolve function or the crate fetcher. Every
> needed information is defined inside the lock file.
>
That's good, and if the lock file is present (versus just a dependency
file), would the processing and creation of the lock file be skipped ?



>
>
>> It is possible to use the vendor package to create a include file but we
>> should have good reasons to support two solutions for the same problem.
>>
>> If that just doesn't make sense, then if there was a way to copy
>> the lockfile out of the recipe and have it overlayed onto the fetched
>> one .. maybe breaking out the individual fetch lines isn't required,
>> since they could be individually manipulated in that lockfile.
>>
>> I haven't test it but this should be possible. You can place a lock file
>> beside the recipe, add it to the SRC_URI and change the XXX_LOCK_PATH.
>>
>
> Something like that is a big step towards having that finer grained
> control in a recipe that
> I'm looking for. I'd still like some sort of line by line "dumped
> dependency list" if there's a
> lower level protocol at play (but the lock file really also is just that
> line by line list for many
> of the languages).
>
> Why you need this finer grained control in the recipe? You have the finer
> grained control in the lock file and additional tools to manage the file
> and all its interdependence. The resolve is deterministic and the .inc is
> only another representation. Manipulation of the representation could lea=
d
> to problems and complicate the process. It's like you translate the .am a=
nd
> .in files into a .inc file to influence the generated automake files.
>
The tools that I'm talking about are a text editor, not anything language
specific.  I don't want or need tools to manipulate those files, I want to
see the base fetches of the dependencies, it is those that I'm manipulating=
.

I'm simply describing what I've done in the past to fix issues with the
builds and pull in fixes, so yes, it is something that I need.


> Would it help if we have a devtool shell so that you can run "cargo
> update" inside the folder created by "devtool modify" to update
> dependencies via the common tools and create a patch?
>

Maybe, but I don't use devtool at all for my recipe maintenance, and I
would push back against it being a requirement to do so.

Bruce

--000000000000b49f83062e090143
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote gmail_quote_con=
tainer"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Feb 13, 2025 at 3:36=
=E2=80=AFAM Stefan Herbrechtsmeier &lt;<a href=3D"mailto:stefan.herbrechtsm=
eier-oss@weidmueller.com">stefan.herbrechtsmeier-oss@weidmueller.com</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><u></u>

 =20
  <div>
    <div>Am 12.02.2025 um 15:11 schrieb Bruce
      Ashfield:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">
        <div dir=3D"ltr">
          <div style=3D"font-size:small"><br>
          </div>
        </div>
        <br>
        <div class=3D"gmail_quote">
          <div dir=3D"ltr" class=3D"gmail_attr">On Wed, Feb 12, 2025 at
            3:41=E2=80=AFAM Stefan Herbrechtsmeier &lt;<a href=3D"mailto:st=
efan.herbrechtsmeier-oss@weidmueller.com" target=3D"_blank">stefan.herbrech=
tsmeier-oss@weidmueller.com</a>&gt;
            wrote:<br>
          </div>
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <div>
              <div>Am 12.02.2025 um 00:14 schrieb Bruce Ashfield via <a hre=
f=3D"http://lists.openembedded.org" target=3D"_blank">lists.openembedded.or=
g</a>:<br>
              </div>
              <blockquote type=3D"cite">
                <pre>In message: [bitbake-devel] [RFC PATCH 00/30] Add vend=
or support for go, npm and rust
on 11/02/2025 Stefan Herbrechtsmeier via <a href=3D"http://lists.openembedd=
ed.org" target=3D"_blank">lists.openembedded.org</a> wrote:

</pre>
                <blockquote type=3D"cite">
                  <pre>From: Stefan Herbrechtsmeier <a href=3D"mailto:stefa=
n.herbrechtsmeier@weidmueller.com" target=3D"_blank">&lt;stefan.herbrechtsm=
eier@weidmueller.com&gt;</a>

The series adds on-the-fly support for package manager specific
dependencies and vendor directories. It contains the following changes:
1. Adds an early fetch, unpack and patch task to unpack and patch source
   code with an embedded lock file for dependencies.
2. Parse the go.sum, Cargo.lock and package-lock.json lock files and
   resolve the dependencies to SRC_URIs.
3. Save the SRC_URIs in a file and adapt all SRC_URIs users to handle
   the SRC_URI files beside the SRC_URIs in the recipe.
</pre>
                </blockquote>
                <pre>I made a few comments, and will have another / better =
look at the
series tomorrow. There&#39;s a lot here, and it is hard to wrap my head
around everything that is changing.

I have one specific question below (from the point of view of go).

I&#39;ve been looking through the series, and can&#39;t pick out where #3 i=
s
done.</pre>
              </blockquote>
              <p>The files are created in the package manager specific
                vendor classes (17 - 19) in the do_vendor_resolve task.
                The parsing is implemented in the package manager
                specific modules in the vendor package (6-8).<br>
                <br>
              </p>
            </div>
          </blockquote>
          <div><br>
          </div>
          <div>
            <div style=3D"font-size:small">aha. I&#39;ll
              have a closer look in a bit!</div>
            <br>
          </div>
          <div>=C2=A0</div>
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <p> </p>
            <blockquote type=3D"cite">
              <pre> I see patch 14 using SRC_URI_FILES, but where are those=
 files
written ? Is that in patch 18 (vendor_go_do_vendor_resolve ?)  What is
written to those files ?</pre>
            </blockquote>
            <p>The file is written into the vendor directory below
              WORKDIR. The approach is similar to other classes which
              need to share data between tasks.<br>
              <br>
              The files contain individual SRC_URIs per line.<br>
            </p>
          </blockquote>
          <div>
            <div style=3D"font-size:small">I may
              have missed that in the patches, but if that isn&#39;t
              described in the commit logs, then</div>
            <div style=3D"font-size:small">that
              description would be a nice addition. Along with a high
              level description for each</div>
            <div style=3D"font-size:small">supported
              language package manager about what is in the files and
              what uses it to</div>
            <div style=3D"font-size:small">resolve
              the dependencies.</div>
          </div>
        </div>
      </div>
    </blockquote>
    <p>I will extend the commit messages.<br>
      <br>
    </p>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div class=3D"gmail_quote">
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <div>
              <p> <br>
              </p>
              <blockquote type=3D"cite">
                <pre>The concept that I&#39;m not understanding (and that&#=
39;s just me not being
familiar with things, I&#39;ll continue reading the series) is that when
we suggested we&#39;d like to have a mode where the dependencies could
clearly be listed in the SRC_URI, at least I was just thinking about a
way run the fetch/module elements that you were adding, write them to
a file and then have the recipe include it.</pre>
              </blockquote>
              <p>The additional SRC_URIs are dynamically added to the
                recipe without the indirection over an include file. The
                generated SRC_URIs could be inspected via the
                SRC_URI_FILES and manipulated via patches for the lock
                files or an separated lock file.=C2=A0</p>
            </div>
          </blockquote>
          <div><span class=3D"gmail_default" style=3D"font-size:small">The
              issue with patching those dynamic files .. is just that,
              they are dynamic and</span></div>
          <div style=3D"font-size:small">they could
            be regenerated (but hopefully without a SRCREV change they
            are identically</div>
          <div style=3D"font-size:small">generated
            each time, so maybe it isn&#39;t a big deal) and patching could
            fail. Much like we</div>
          <div style=3D"font-size:small">don&#39;t patch
            generated automake files, we patch the .am and .in files
            that generate the</div>
          <div style=3D"font-size:small">outputs.<br>
          </div>
        </div>
      </div>
    </blockquote>
    <p>You can&#39;t compare lock files with automake files. The lock files
      is generated but it contains additional information. The only
      difference is that a program and not a human write the file. If an
      update creates too much noise in the file we should discuss with
      upstream how to minimize it.=C2=A0 The lock file is designed to be
      under revision control and shouldn&#39;t change without reason.
      Dependabot automatically creates updates and pull requests for
      dependency updates. This will not work if the lock file isn&#39;t
      deterministic.<br></p></div></blockquote><div><br></div><div><div cla=
ss=3D"gmail_default" style=3D"font-size:small">I may be using different ter=
minology, but I do know what the lock files are (I interchange the dependen=
cy and lock files at times though), patching *anything* that is generated i=
s a bad idea, that&#39;s my point (so the comparison is valid).</div></div>=
<div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div><p>
      <br>
    </p>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div class=3D"gmail_quote">
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <div>
              <p> <br>
                <span style=3D"white-space:pre-wrap">
</span></p>
              <blockquote type=3D"cite">
                <pre>I can&#39;t tell if in the series those files are writ=
ten each time, and
that there would be no way to edit those SRC_URI_FILES .. but I&#39;ll
look again tomorrow.</pre>
              </blockquote>
              <p>The files are written if the do_vendor_resolve task
                need to be rerun. It isn&#39;t possible to edit the
                generated SRC_URIs. Instead the lock file could be
                patched.<br>
                <span style=3D"white-space:pre-wrap"></span></p>
            </div>
          </blockquote>
          <div><br>
          </div>
          <div>
            <div style=3D"font-size:small">ok. So
              they are really just a way to dump what is being built to
              disk and out of &quot;memory&quot;,</div>
            <div style=3D"font-size:small">it really
              isn&#39;t what I was looking for, but at least I understand
              what you were trying to</div>
            <div style=3D"font-size:small">do with
              the writing and later use of the files now.</div>
          </div>
          <div><br>
          </div>
          <div>
            <div style=3D"font-size:small">I was
              hoping for something that I could include &quot;statically&qu=
ot;
              (for lack of a better term) in my</div>
            <div style=3D"font-size:small">recipes,
              and then have the handlers for the protocols do the
              fetching .. again, much like</div>
            <div style=3D"font-size:small">the
              crate:// fetches in the .inc files.</div>
          </div>
        </div>
      </div>
    </blockquote>
    <p>I don&#39;t use the fetcher because of its drawbacks and limitations=
.
      I use the same wget URL without the indirection over the package
      manager specific fetchers. I can follow the pypi approach to
      generate SRC_URIs which call a python function:</p></div></blockquote=
><div><span class=3D"gmail_default" style=3D"font-size:small"></span></div>=
<div class=3D"gmail_default" style=3D"font-size:small">Can you elaborate on=
 the limitations ?</div><div class=3D"gmail_default" style=3D"font-size:sma=
ll"><br></div><div class=3D"gmail_default" style=3D"font-size:small">=C2=A0=
Although from your description, I&#39;m fine calling wget a &quot;fetcher&q=
uot;. I&#39;m just talking about something that pulls in the dependency sou=
rce code, whether it be git, wget, or some other protocol, it&#39;s the con=
cept that is the same.</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x"><div>
    <p>${@crate_src_uri(d, &#39;xyz&#39;, &#39;1.2.3&#39;)}<br>
      <br>
      But why you need this? In any case the manipulation of a
      dependency could lead to interdependence between dependencies.<span c=
lass=3D"gmail_default" style=3D"font-size:small">\</span></p></div></blockq=
uote><div><br></div><div><div class=3D"gmail_default" style=3D"font-size:sm=
all">Because I need to redirect and update them manually. Anything that run=
s in python to determine the fetch is also hard to debug, since I&#39;d be =
interested in the output of that processing if there&#39;s an issue.</div><=
div class=3D"gmail_default" style=3D"font-size:small"><br></div><div class=
=3D"gmail_default" style=3D"font-size:small">I&#39;m describing something l=
ike (and I&#39;m describing it badly .. but I&#39;ll try anyway:</div><div =
class=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D"g=
mail_default" style=3D"font-size:small">=C2=A0&lt;language file that descri=
bes the dependencies&gt;</div><div class=3D"gmail_default" style=3D"font-si=
ze:small">=C2=A0&lt;process that file into a specific source=C2=A0 revision=
 and fetch/download location&gt;</div><div class=3D"gmail_default" style=3D=
"font-size:small">=C2=A0&lt;have a language / protocol specific fetcher get=
 the modules / source code iteratively from a list of expanded dependencies=
&gt;</div><div class=3D"gmail_default" style=3D"font-size:small">=C2=A0&lt;=
put them into place for the build&gt;</div><div class=3D"gmail_default" sty=
le=3D"font-size:small">=C2=A0&lt;arrange for the build to use those fetched=
 depdendencies&gt;</div><div class=3D"gmail_default" style=3D"font-size:sma=
ll"><br></div><div class=3D"gmail_default" style=3D"font-size:small">wget w=
ould fall into that &quot;language specific fetcher&quot;, as would git or=
=C2=A0&quot;go vendor&quot; (Although I don&#39;t really like that, since i=
t isn&#39;t transparent where the source code is being pulled from).=C2=A0 =
Copying the files into vendor, or again &quot;go mod vendor&quot; (doing bo=
th the fetch and placement) would be the &quot;put them in place for the bu=
ild&quot;.</div><div class=3D"gmail_default" style=3D"font-size:small"><br>=
</div><div class=3D"gmail_default" style=3D"font-size:small">I realize that=
 is what your series is doing.</div><div class=3D"gmail_default" style=3D"f=
ont-size:small"><br></div><div class=3D"gmail_default" style=3D"font-size:s=
mall">The processing, fetching,=C2=A0placement=C2=A0 stages could run fully=
 behind the scenes from a dependency/lock file, or be skipped if broken out=
 into the list of fetches (from the SCR_URI (via .inc file or whatever)). T=
hose are the two modes I&#39;m describing, where the &quot;processing the f=
ile into a specific source revision / fetch steps&quot; can be avoided.</di=
v><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex"><div><p><br>
      <br>
    </p>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div class=3D"gmail_quote">
          <div>
            <div style=3D"font-size:small">To be
              clear, I&#39;m not suggesting that mode would be the only
              mode, just that the way the</div>
            <div style=3D"font-size:small">generation
              of the fetches -&gt; actual fetching was constructed such
              that I could avoid</div>
            <div style=3D"font-size:small">&quot;short
              circuit&quot; the handling of the lock file and simply list t=
he
              dependencies for fetching</div>
            <div style=3D"font-size:small">(much
              like how I can go get all of the SRCREVS for a gitsm://
              fetch, and put them into</div>
            <div style=3D"font-size:small">my
              recipes as pure git:// fetches if I&#39;m having issues with
              the git submodles).<br>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    Add a function to create this file isn&#39;t a problem, but I can&#39;t
    ensure that this will work in any case and doesn&#39;t create problems
    because of the discrepancy between the manifest / lock file and the
    available sources.<br></div></blockquote><div><br></div><div><div class=
=3D"gmail_default" style=3D"font-size:small">Right, and that is fine. If so=
meone bumps a revision to the point where the dependency now has different =
dependencies that are not in the lock file, then they&#39;ve taken things f=
ully into their control and need to deal with any issues.=C2=A0 That obviou=
sly isn&#39;t the default, but does allow an advanced user/developer the po=
ssibility to have fine grained control and debug.</div></div><div>=C2=A0</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex"><div>
    <br>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div class=3D"gmail_quote">
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <div>
              <p><span style=3D"white-space:pre-wrap">

</span></p>
              <blockquote type=3D"cite">
                <pre>That file would manipulate the standard SRC_URI. In ot=
her words still
support a mode that is like the .inc files with crate://. So someone
could either have the lockfile parsed and fetched, or have a way to
run the parsing and fetching via a task, write a file and include the
file in their recipe to short circuit the processing of the lockfile.
(meaning the expanded and end fetches that are done once you&#39;ve
processed the file are simply listed as a series of fetches that are
carried out without extra processing .. and &quot;unrolled&quot; dependency
file pointing at the &quot;sources&quot; git, crate, mod, whatever)
</pre>
              </blockquote>
              <p>What is the motivation &quot;to short circuit the processi=
ng
                of the lockfile&quot;? Like any task the processing and its
                output are cached via the sstate cache.<br>
              </p>
            </div>
          </blockquote>
          <div><br>
          </div>
          <div style=3D"font-size:small">See above.
            It isn&#39;t about re-running it a later time and re-using the
            artifacts, it is about</div>
          <div style=3D"font-size:small">having a
            way to make sure nothing is dynamically=C2=A0resolved when
            bitbake &lt;foo&gt; is called,</div>
          <div style=3D"font-size:small">just fetch
            and the rest of the standard tasks.<br>
          </div>
        </div>
      </div>
    </blockquote>
    <p>The resolve always create the same URL like the crate fetcher. It
      only changes if you change the resolve function or the crate
      fetcher. Every needed information is defined inside the lock file.<br=
></p></div></blockquote><div><div class=3D"gmail_default" style=3D"font-siz=
e:small">That&#39;s good, and if the lock file is present (versus just a de=
pendency file), would the processing and creation of the lock file be skipp=
ed ?</div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex"><div><p>
      <br>
    </p>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div class=3D"gmail_quote">
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <div>
              <p> <br>
                It is possible to use the vendor package to create a
                include file but we should have good reasons to support
                two solutions for the same problem.<br>
                <br>
              </p>
              <blockquote type=3D"cite">
                <pre>If that just doesn&#39;t make sense, then if there was=
 a way to copy
the lockfile out of the recipe and have it overlayed onto the fetched
one .. maybe breaking out the individual fetch lines isn&#39;t required,
since they could be individually manipulated in that lockfile.</pre>
              </blockquote>
              <p>I haven&#39;t test it but this should be possible. You can
                place a lock file beside the recipe, add it to the
                SRC_URI and change the XXX_LOCK_PATH.<br>
              </p>
            </div>
          </blockquote>
          <div><br>
          </div>
          <div style=3D"font-size:small">Something
            like that is a big step towards having that finer grained
            control in a recipe that</div>
          <div style=3D"font-size:small">I&#39;m looking
            for. I&#39;d still like some sort of line by line &quot;dumped
            dependency list&quot; if there&#39;s a</div>
          <div style=3D"font-size:small">lower level
            protocol at play (but the lock file really also is just that
            line by line list for many</div>
          <div style=3D"font-size:small">of the
            languages).<br>
          </div>
        </div>
      </div>
    </blockquote>
    <p>Why you need this finer grained control in the recipe? You have
      the finer grained control in the lock file and additional tools to
      manage the file and all its interdependence. The resolve is
      deterministic and the .inc is only another representation.
      Manipulation of the representation could lead to problems and
      complicate the process. It&#39;s like you translate the .am and .in
      files into a .inc file to influence the generated automake files.<br>=
</p></div></blockquote><div><div class=3D"gmail_default" style=3D"font-size=
:small">The tools that I&#39;m talking about are a text editor, not anythin=
g language specific.=C2=A0 I don&#39;t want or need tools to manipulate tho=
se files, I want to see the base fetches of the dependencies, it is those t=
hat I&#39;m manipulating.</div><div class=3D"gmail_default" style=3D"font-s=
ize:small"><br></div><div class=3D"gmail_default" style=3D"font-size:small"=
>I&#39;m simply describing what I&#39;ve done in the past to fix issues wit=
h the builds and pull in fixes, so yes, it is something that I need.</div><=
/div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div>=
<p>
      <br>
      Would it help if we have a devtool shell so that you can run
      &quot;cargo update&quot; inside the folder created by &quot;devtool m=
odify&quot; to
      update dependencies via the common tools and create a patch?<br></p><=
/div></blockquote><div><br></div><div><div class=3D"gmail_default" style=3D=
"font-size:small">Maybe, but I don&#39;t use devtool at all for my recipe m=
aintenance, and I would push back against it being a requirement to do so.=
=C2=A0</div><div class=3D"gmail_default" style=3D"font-size:small"><br></di=
v><div class=3D"gmail_default" style=3D"font-size:small">Bruce</div></div><=
div class=3D"gmail_default" style=3D"font-size:small"><br></div></div></div=
>

--000000000000b49f83062e090143--

