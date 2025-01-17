Return-Path: <bruce.ashfield@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB1FC02183
	for <webhook@archiver.kernel.org>; Fri, 17 Jan 2025 04:20:16 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.web11.4125.1737087611695024832
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Jan 2025 20:20:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=jucKeune;
 spf=pass (domain: gmail.com, ip: 209.85.216.47, mailfrom: bruce.ashfield@gmail.com)
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2f13acbe29bso4509566a91.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 16 Jan 2025 20:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737087611; x=1737692411; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gtuS2s11bXWfBtT2xDPKtSp1XqinYjo3VkNko8yCOm4=;
        b=jucKeuneO2FTSBPEcxUJmcHVklsZ0vBUKJXTNDRKuxUgzhIKopvA0xxLqOcR9lcIRY
         BWC+C4t7gdWN2Ls4zRbf7MYjlBfhygGeHhsBz0imaw1gFsKpgLtz372uawtQbFScYFm/
         EXG35sluPe1HJRpRxJouVaC43bp1K+445NqFShsaDnguYo6yhlMQrOrG2zu0txFJpvJY
         7SSCWBcCt5Lf3lDtmQVUc6ayw8hptTTNLSR53tYGtCBCh3ivAPtrxZdxwFuUpdQ5tTjP
         uGC+Cx1u7UyLBjTiGmHBGRWbXM31btrFxECuFI2RF/sBrSnXO/myzwQq6INmeKBRFYE0
         lQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737087611; x=1737692411;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gtuS2s11bXWfBtT2xDPKtSp1XqinYjo3VkNko8yCOm4=;
        b=T/GDYD/1jDbbtTKbxvcIeThUMVl17UxvgGBGPoaHUA+WETUotdWazLTp4K4LFt7Z8G
         DC9FroN3/FzYH7Nri8qMXrZabH9MGEdrJBxBsrazzL+4KF4PLPiRWKL3yTPK+95sQvwj
         PctfN1nfwwNHYh/hWnREKMe89BVp/0tuvmdPmfLCbpXI3zQNYxQo3YesFOlomfxJsf9q
         pyg0QRGI2XARs+gwD/hbWazSI9TUdW0pf9EgjUwOYTJsdXbJ1KnZZZrbHpWXry+9woAZ
         jl8gz3iyq8XES1HQ+LGqK9+2g01FY12HSKkkD1ekmuENA20NZCAaW5uxb9bzbHRo/Nr+
         xLPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhcykPpAwvykns4ol7PV/aGfNy0AYRT1kPfPbvbMVrcgLfRilNltnXExxGyDVubOYcuZtf/SZIMzs/+DbT@lists.openembedded.org
X-Gm-Message-State: AOJu0Yx6zl+BCPe+8cIN/VFzryshC5La8ioOPAf46v0wgiFimqXEifcl
	oWT9yKHCfEEC5NU5P/vb20GF0txfIwa6IccleIMxWkthVN+HgMLq5hdFFvZuj3CkGaiFgx8Mnqr
	pEBvumpjJDzybKYNK3rcjn97lvcY=
X-Gm-Gg: ASbGncvuk7ED6stnNIuzLrF4zC4zHnnBB7QXAUpIdeSYp2neloyWxPV4DjwmvFpDDOA
	5PGWPEYfx6vSvJNb8PWkjh3KCE07IfVVS47RV7wwLPDZ9/ZExNLbc
X-Google-Smtp-Source: AGHT+IHU7CjuIAjI+jitqAaKd+3dDBOdAKNH1pRt8rJ2lU21Jat862uI6y9nNTZXwz38Pmgq+OUed1K27jlTx9QYygI=
X-Received: by 2002:a17:90b:258b:b0:2f2:a974:1e45 with SMTP id
 98e67ed59e1d1-2f782d21048mr1744553a91.16.1737087610924; Thu, 16 Jan 2025
 20:20:10 -0800 (PST)
MIME-Version: 1.0
References: <20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
 <aeac8b24d43c57b7b426983ae50ec65680dafc24.camel@linuxfoundation.org>
 <CANNYZj9q6+D6AppzUbuV_cdMszt_KA3kfsamOtcRFxoWWFjV+A@mail.gmail.com>
 <513bf8f4-fb14-42dd-89fb-275e4b468924@weidmueller.com> <CANNYZj_z49bpc7fnvKO737La2YHy7zCPsgzwhS-G+=OQfi6uUQ@mail.gmail.com>
 <c164bf03-b00c-421e-a41c-441fe911eac5@weidmueller.com> <CANNYZj_-+uq0HmLYWAU1kEBPdkiCfyjkAu8cdSjxt6PsCB=-9A@mail.gmail.com>
 <7121dc06-215a-4481-be8e-7094a45e43ad@weidmueller.com> <CANNYZj_Ddh0zWbE79G5TAwQrU805WrrzDbjJTopT7EgLALBgQg@mail.gmail.com>
 <4f1f10ac-4a71-4b2b-9ea7-63e1da5d3e94@weidmueller.com> <CADkTA4MtLO90FW6YfeHDh7Lyo7=DRvxm6xf8Q0LkhC+u0U15iQ@mail.gmail.com>
 <1d86a392-db47-4fac-81fe-5262477bcd70@weidmueller.com>
In-Reply-To: <1d86a392-db47-4fac-81fe-5262477bcd70@weidmueller.com>
From: Bruce Ashfield <bruce.ashfield@gmail.com>
Date: Thu, 16 Jan 2025 23:19:59 -0500
X-Gm-Features: AbW1kvbD4EmzCVOpamCaEJJaw9FxgEx0YRObdT1tXUb67mVvQ8-mbCQ4ArGDseg
Message-ID: <CADkTA4PeRvBoR-F3pM-XOjWKEjsgLX+entDPv1uL+uTiFxjc=w@mail.gmail.com>
Subject: Re: [bitbake-devel] [RFC PATCH 00/21] Concept for tightly coupled
 package manager (Node.js, Go, Rust)
To: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
Cc: Alexander Kanavin <alex.kanavin@gmail.com>, richard.purdie@linuxfoundation.org, 
	bitbake-devel@lists.openembedded.org, 
	Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Content-Type: multipart/alternative; boundary="000000000000fe3570062bdf3909"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Jan 2025 04:20:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17020

--000000000000fe3570062bdf3909
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 2:11=E2=80=AFAM Stefan Herbrechtsmeier <
stefan.herbrechtsmeier-oss@weidmueller.com> wrote:

> Am 10.01.2025 um 21:24 schrieb Bruce Ashfield:
>
> On Fri, Jan 10, 2025 at 10:04=E2=80=AFAM Stefan Herbrechtsmeier via
> lists.openembedded.org <stefan.herbrechtsmeier-oss=3D
> weidmueller.com@lists.openembedded.org> wrote:
>
>> Am 10.01.2025 um 14:26 schrieb Alexander Kanavin:
>>
>> On Fri, 10 Jan 2025 at 12:32, Stefan Herbrechtsmeier<stefan.herbrechtsme=
ier-oss@weidmueller.com> <stefan.herbrechtsmeier-oss@weidmueller.com> wrote=
:
>>
>> What is your opinion regarding gitsm. Should we remove the bitbake fetch=
er and use a update task to generate a inc file with the source uris and so=
urce revisions?
>>
>> That ship has sailed. We can't remove gitsm, it has users, and they
>> will be very angry.
>>
>> This makes it impossible to fix wrong design decision or remove code wit=
h
>> a low code quality.
>>
>> Do you really review the changes of the inc file?
>> I understand the points but I have the feeling that they are more theore=
tically for package manager dependencies or could be solved in an other way=
 (ex. caching)
>>
>> But do you? I have to restate the point: a solution that can be placed
>> inside a layer is much more scalable and maintainable than adding code
>> to bitbake. That's why I'm leaning towards drawing the line at
>> existing fetchers that are wget/git convenience wrappers, and shifting
>> dependency/lockfile management to layers. It's ultimately RP's call,
>> but he does seek feedback :)
>>
>> I'm working on it.
>>
>> I'm fine with large SRC_URI/sha256 diffs when recipes get updated to
>> new versions. And since you asked, no, no one looks at them, they're
>> auto-generated noise that we learned to block out, just as we learned
>> to quickly skim over recipe patch changes that are just line number
>> churn and similar non-functional changes.
>>
>> Instead of an inc file the generated SRC_URIs could be saved inside the
>> work directory of the recipe. This will eliminate the noise and avoid a
>> manual run of an update task after a recipe changes.
>>
>
> Except for those that want the .inc file changes to be version controlled
> (as well as SRC_URI changes), but maybe I'm misunderstanding what you
> described above
>
> Why should somebody version control the generated SRC_URI?
>
>
> Why wouldn't they ? I'm talking about when the SRC_URI is generated to gi=
t
fetches (or whatever), that is part of the recipe and version controlled.

My point is that this is not throw away / transient information for many
use cases. It is something that can be tracked between updates to the
recipes.



> A generated temporary/build file is definitely more visible than somethin=
g
> that is programmatically done and held internally during recipe processin=
g
> and build.  It opens the door for extension and doing version control on
> it.  So I don't object to the concept, I just don't think I have all the
> details straight in my head.
>
> A generated build file will be saved in the work directory of the recipe
> like any other generated build file. It is impossible to add it to the
> version control system. The update task create a version controlled
> generated source file. I don't understand why the version control is need=
ed
> because the source of the generator and the generator are version
> controlled. Especially if the output is ignored during patch review. I
> think it is much more straightforward to patch the source (lock file)
> because it is complicated to handle manual changes during regeneration of=
 a
> generated file.
>
*sigh*. I'm quite aware of what can and cannot be done. That's not what I
meant. I'm obviously not talking about something in WORKDIR. I'm just
saying that if something is written to disk, then depending on how things
are implemented it can be viewed, debugged and manipulated. If it is always
generated, held internally to the classes and used, I have no options to do
that sort of debug. Similarly, anything that is generated, it would be
ideal if there was a way to re-use a previously generated artifact and not
generate it on the fly .. that's the element that opens the door to version
control and tracking.

We'll agree to disagree on what is or isn't efficient or complicated.
Luckily, this is all opt-in, so I'll never really have to use it. I'm just
sharing what it would take to get me to consider it based on what I've
learned/suffered in my time maintaining quite a few go recipes.

Cheers,

Bruce


> Even if we put all license information inside the inc file. Who should re=
view the changes ? What tooling is used to review the change (license conte=
nt)? If we blindly trust the inc file generator, the inc file is useless an=
d we can generate the information on-the-fly.
>>
>> We won't blindly trust a generator. There are multiple gate-keeping
>> steps, some of which already work, and some should still be
>> implemented:
>>
>> - when creating a recipe with devtool, devtool should discover all
>> licenses and generate appropriate recipe metadata. For classic unix-y
>> components this has to rely on 'guessing', but things like crates have
>> deterministic licensing metadata (a field in Cargo.toml, and LICENSE-*
>> files if I remember right). We can also propose adding such
>> determinism upstream if it's not currently good enough.
>>
>> - when updating a recipe with devtool to a new upstream release, it
>> uses the file:// entries in LIC_FILES_CHKSUM to generate a diff of
>> previous license texts and the new ones, and writes that as a comment
>> into the updated recipe. The diff is reviewed by a human performing
>> the update, and condensed into an update to the LICENSE field (if
>> needed), and an explanation of what changed in the License-Update tag
>> in the commit message. This could be further automated if upstream has
>> deterministic ways to specify licenses, e.g. LICENSE =3D
>> "&".join(all_license_ids).
>>
>> - when sending the resulting patch for review, there's a mailing list
>> bot (patchtest), which will check that any update in license checksums
>> is accompanied by an explanation in License-Update tag. There are also
>> humans which will check that the licensing changes are sensible.
>> Otherwise we do trust that submitters spot important changes in
>> licensing (from the diff in the previous step or by manual comparison,
>> if they want) and summarise them in LICENSE correctly.
>>
>> - finally there are various license checks that run in recipe_qa task
>> and implemented in insane.bbclass. They could be extended to verify
>> that every dependency has a matching license entry in the recipe and
>> so on. Anything that can be caught by looking at the source tree and
>> the license metadata.
>>
>> This works for individual project but become complicated for dependencie=
s
>> because you have to handle the same change multiple times. But lets stop
>> the discussion for now because license is out of scope of this series.
>>
>> Nevertheless I will move my implementation to oe-core and add a task to =
generate an inc file as starting point.
>>
>> That would be much appreciated. The more I think about it the more I'm
>> convinced we should have it standardized in core.
>>
>> What do you mean by standardized?
>>
>>
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>> Links: You receive all messages sent to this group.
>> View/Reply Online (#17006):
>> https://lists.openembedded.org/g/bitbake-devel/message/17006
>> Mute This Topic: https://lists.openembedded.org/mt/110212697/1050810
>> Group Owner: bitbake-devel+owner@lists.openembedded.org
>> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
>> bruce.ashfield@gmail.com]
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>
>>
>
> --
> - Thou shalt not follow the NULL pointer, for chaos and madness await the=
e
> at its end
> - "Use the force Harry" - Gandalf, Star Trek II
>
>

--=20
- Thou shalt not follow the NULL pointer, for chaos and madness await thee
at its end
- "Use the force Harry" - Gandalf, Star Trek II

--000000000000fe3570062bdf3909
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote gmail_quote_con=
tainer"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jan 13, 2025 at 2:11=
=E2=80=AFAM Stefan Herbrechtsmeier &lt;<a href=3D"mailto:stefan.herbrechtsm=
eier-oss@weidmueller.com">stefan.herbrechtsmeier-oss@weidmueller.com</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><u></u>

 =20
  <div>
    <div>Am 10.01.2025 um 21:24 schrieb Bruce
      Ashfield:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">
        <div class=3D"gmail_quote">
          <div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jan 10, 2025 at
            10:04=E2=80=AFAM Stefan Herbrechtsmeier via <a href=3D"http://l=
ists.openembedded.org" target=3D"_blank">lists.openembedded.org</a>
            &lt;stefan.herbrechtsmeier-oss=3D<a href=3D"mailto:weidmueller.=
com@lists.openembedded.org" target=3D"_blank">weidmueller.com@lists.openemb=
edded.org</a>&gt;
            wrote:<br>
          </div>
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <div>
              <div>Am 10.01.2025 um 14:26 schrieb Alexander Kanavin:<br>
              </div>
              <blockquote type=3D"cite">
                <pre>On Fri, 10 Jan 2025 at 12:32, Stefan Herbrechtsmeier
<a href=3D"mailto:stefan.herbrechtsmeier-oss@weidmueller.com" target=3D"_bl=
ank">&lt;stefan.herbrechtsmeier-oss@weidmueller.com&gt;</a> wrote:
</pre>
                <blockquote type=3D"cite">
                  <pre>What is your opinion regarding gitsm. Should we remo=
ve the bitbake fetcher and use a update task to generate a inc file with th=
e source uris and source revisions?
</pre>
                </blockquote>
                <pre>That ship has sailed. We can&#39;t remove gitsm, it ha=
s users, and they
will be very angry.</pre>
              </blockquote>
              <p>This makes it impossible to fix wrong design decision
                or remove code with a low code quality.<br>
                <span style=3D"white-space:pre-wrap">

</span></p>
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <pre>Do you really review the changes of the inc file?
I understand the points but I have the feeling that they are more theoretic=
ally for package manager dependencies or could be solved in an other way (e=
x. caching)
</pre>
                </blockquote>
                <pre>But do you? I have to restate the point: a solution th=
at can be placed
inside a layer is much more scalable and maintainable than adding code
to bitbake. That&#39;s why I&#39;m leaning towards drawing the line at
existing fetchers that are wget/git convenience wrappers, and shifting
dependency/lockfile management to layers. It&#39;s ultimately RP&#39;s call=
,
but he does seek feedback :)</pre>
              </blockquote>
              I&#39;m working on it.<br>
              <br>
              <blockquote type=3D"cite">
                <pre>I&#39;m fine with large SRC_URI/sha256 diffs when reci=
pes get updated to
new versions. And since you asked, no, no one looks at them, they&#39;re
auto-generated noise that we learned to block out, just as we learned
to quickly skim over recipe patch changes that are just line number
churn and similar non-functional changes.</pre>
              </blockquote>
              <p> Instead of an inc file the generated SRC_URIs could be
                saved inside the work directory of the recipe. This will
                eliminate the noise and avoid a manual run of an update
                task after a recipe changes.<br>
                <span style=3D"white-space:pre-wrap"></span></p>
            </div>
          </blockquote>
          <div><br>
          </div>
          <div>
            <div style=3D"font-size:small">Except
              for those that want the .inc file changes=C2=A0to be version
              controlled (as well as SRC_URI changes), but maybe I&#39;m
              misunderstanding what you described above</div>
          </div>
        </div>
      </div>
    </blockquote>
    <p>Why should somebody version control the generated SRC_URI?<br>
    </p>
    <p><br></p></div></blockquote><div><span class=3D"gmail_default" style=
=3D"font-size:small">Why wouldn&#39;t they ? I&#39;m talking about when the=
 SRC_URI is generated to git fetches (or whatever), that is part of the rec=
ipe and version controlled.</span></div><div><br></div><div><div class=3D"g=
mail_default" style=3D"font-size:small">My point is that this is not throw =
away / transient information for many use cases. It is something that can b=
e tracked between updates to the recipes.</div><br></div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex"><div><p>
    </p>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div class=3D"gmail_quote">
          <div>
            <div style=3D"font-size:small">A
              generated temporary/build file is definitely more visible
              than something that is programmatically done and held
              internally during recipe processing and build.=C2=A0 It opens
              the door for extension and doing version control on it.=C2=A0
              So I don&#39;t object to the concept, I just don&#39;t think =
I
              have all the details straight in my head.<br>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <p>A generated build file will be saved in the work directory of the
      recipe like any other generated build file. It is impossible to
      add it to the version control system. The update task create a
      version controlled generated source file. I don&#39;t understand why
      the version control is needed because the source of the generator
      and the generator are version controlled. Especially if the output
      is ignored during patch review. I think it is much more
      straightforward to patch the source (lock file) because it is
      complicated to handle manual changes during regeneration of a
      generated file.<br></p></div></blockquote><div><span class=3D"gmail_d=
efault" style=3D"font-size:small">*sigh*. I&#39;m quite aware of what can a=
nd cannot be done. That&#39;s not what I meant. I&#39;m obviously not talki=
ng about something in WORKDIR. I&#39;m just saying that if something is wri=
tten to disk, then depending on how things are implemented it can be viewed=
, debugged=C2=A0and manipulated. If it is always generated, held internally=
 to the classes and used, I have no options to do that sort of debug. Simil=
arly, anything that is generated, it would be ideal if there was a way to r=
e-use=C2=A0a previously generated artifact and not generate it on the fly .=
. that&#39;s the element that opens the door to version control and trackin=
g.</span></div><div><br></div><div><div class=3D"gmail_default" style=3D"fo=
nt-size:small">We&#39;ll agree to disagree on what is or isn&#39;t efficien=
t or complicated. Luckily, this is all opt-in, so I&#39;ll never really hav=
e to use it. I&#39;m just sharing what it would take to get me to consider =
it based on what I&#39;ve learned/suffered in my time maintaining=C2=A0quit=
e a few go recipes.</div></div><div><br></div><div class=3D"gmail_default" =
style=3D"font-size:small">Cheers,</div><div class=3D"gmail_default" style=
=3D"font-size:small"><br></div><div class=3D"gmail_default" style=3D"font-s=
ize:small">Bruce</div><div class=3D"gmail_default" style=3D"font-size:small=
"><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div><p>
      <br>
    </p>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div class=3D"gmail_quote">
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <div>
              <p><span style=3D"white-space:pre-wrap">

</span></p>
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <pre>Even if we put all license information inside the in=
c file. Who should review the changes ? What tooling is used to review the =
change (license content)? If we blindly trust the inc file generator, the i=
nc file is useless and we can generate the information on-the-fly.
</pre>
                </blockquote>
                <pre>We won&#39;t blindly trust a generator. There are mult=
iple gate-keeping
steps, some of which already work, and some should still be
implemented:

- when creating a recipe with devtool, devtool should discover all
licenses and generate appropriate recipe metadata. For classic unix-y
components this has to rely on &#39;guessing&#39;, but things like crates h=
ave
deterministic licensing metadata (a field in Cargo.toml, and LICENSE-*
files if I remember right). We can also propose adding such
determinism upstream if it&#39;s not currently good enough.

- when updating a recipe with devtool to a new upstream release, it
uses the <a>file://</a> entries in LIC_FILES_CHKSUM to generate a diff of
previous license texts and the new ones, and writes that as a comment
into the updated recipe. The diff is reviewed by a human performing
the update, and condensed into an update to the LICENSE field (if
needed), and an explanation of what changed in the License-Update tag
in the commit message. This could be further automated if upstream has
deterministic ways to specify licenses, e.g. LICENSE =3D
&quot;&amp;&quot;.join(all_license_ids).

- when sending the resulting patch for review, there&#39;s a mailing list
bot (patchtest), which will check that any update in license checksums
is accompanied by an explanation in License-Update tag. There are also
humans which will check that the licensing changes are sensible.
Otherwise we do trust that submitters spot important changes in
licensing (from the diff in the previous step or by manual comparison,
if they want) and summarise them in LICENSE correctly.

- finally there are various license checks that run in recipe_qa task
and implemented in insane.bbclass. They could be extended to verify
that every dependency has a matching license entry in the recipe and
so on. Anything that can be caught by looking at the source tree and
the license metadata.</pre>
              </blockquote>
              This works for individual project but become complicated
              for dependencies because you have to handle the same
              change multiple times. But lets stop the discussion for
              now because license is out of scope of this series.<br>
              <br>
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">
                  <pre>Nevertheless I will move my implementation to oe-cor=
e and add a task to generate an inc file as starting point.
</pre>
                </blockquote>
                <pre>That would be much appreciated. The more I think about=
 it the more I&#39;m
convinced we should have it standardized in core.</pre>
              </blockquote>
              What do you mean by standardized?<br>
              <br>
              <p><span style=3D"white-space:pre-wrap">
</span></p>
            </div>
            <br>
            -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
            Links: You receive all messages sent to this group.<br>
            View/Reply Online (#17006): <a href=3D"https://lists.openembedd=
ed.org/g/bitbake-devel/message/17006" rel=3D"noreferrer" target=3D"_blank">=
https://lists.openembedded.org/g/bitbake-devel/message/17006</a><br>
            Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/1=
10212697/1050810" rel=3D"noreferrer" target=3D"_blank">https://lists.openem=
bedded.org/mt/110212697/1050810</a><br>
            Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.open=
embedded.org" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org<=
/a><br>
            Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbak=
e-devel/unsub" rel=3D"noreferrer" target=3D"_blank">https://lists.openembed=
ded.org/g/bitbake-devel/unsub</a>
            [<a href=3D"mailto:bruce.ashfield@gmail.com" target=3D"_blank">=
bruce.ashfield@gmail.com</a>]<br>
            -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
            <br>
          </blockquote>
        </div>
        <div><br clear=3D"all">
        </div>
        <div><br>
        </div>
        <span class=3D"gmail_signature_prefix">-- </span><br>
        <div dir=3D"ltr" class=3D"gmail_signature">- Thou shalt not follow
          the NULL pointer, for chaos and madness await thee at its end<br>
          - &quot;Use the force Harry&quot; - Gandalf, Star Trek II<br>
          <br>
        </div>
      </div>
    </blockquote>
  </div>

</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature">- Thou shalt not follow the NULL pointer, for chaos and madness a=
wait thee at its end<br>- &quot;Use the force Harry&quot; - Gandalf, Star T=
rek II<br><br></div></div>

--000000000000fe3570062bdf3909--

