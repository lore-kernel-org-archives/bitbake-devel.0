Return-Path: <bruce.ashfield@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4963DC02183
	for <webhook@archiver.kernel.org>; Fri, 17 Jan 2025 14:09:19 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web11.11309.1737122956148232643
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Jan 2025 06:09:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=TxHbfxHa;
 spf=pass (domain: gmail.com, ip: 209.85.216.48, mailfrom: bruce.ashfield@gmail.com)
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ee786b3277so2913025a91.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 17 Jan 2025 06:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737122955; x=1737727755; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U3bkDQH2kvp9fWpPf/+I37oU5xCkckjUGdOyFyIQcvk=;
        b=TxHbfxHaTQ3F9pHkB0W08U2AcFlkLOeQCghKvj9CNAHZD4Q6ukuOag5uNZSeZBv2uu
         t8V05vmmdcxGXRmLE4VO2kX84sD1yPacqYVj04CnX5QCcsxS/uyQw+Vh8iH/v8J1vhZy
         s0rzK0BsRg7IiIVaJOWXkP5vsDyOCyjUp5dqPFRVmPKXBv13uNh/K8ucgCW85H7XuZEH
         3rGxMJm9YE++XJ5gZ5PRG0N5OPtf/E/w/sJbKONuEZPpjnh4RP725bnkcKaJUoir6Npj
         x3zrhbY7Vl6dWJwBlk6LvTWiQ1V8wldl4dj8Cf6WkSP3mx9VSsjakvbYOVtpSu/h881J
         LQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737122955; x=1737727755;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U3bkDQH2kvp9fWpPf/+I37oU5xCkckjUGdOyFyIQcvk=;
        b=HHUSWgVmE9j5SbPUbFfTDcshXLylxyKWW3buXGa63s4qlH3GfG9FyVDLcv3kIxCVUW
         GBNmhaY1bgVyORCP3n3IyKXvmKtBrFdUD41dt/7cNPTm2Qzi8w5SJkccMUhXj+mYP2EF
         eBybFzGtMTS4AVTCS56hotHqKEpfdqtKLY4PUYF6JTJTC1HkW3zH4fLLTRHZuonJmVPB
         fbolUpc4oYoRCyAQY+/c5NEJniJUjThNH1Rd8H8ybEgfyvPGn9qAhKBqfB4OQT6SxSQ3
         QCPNE87q/JGvsoOx/NVU6ku242G6PS8+CQE2CIlGS7T9poscQdYebEP9Qp54uCbaNw4f
         Zp+w==
X-Gm-Message-State: AOJu0Yw/QLwmP5K9DrVQMwyAD/PINc2QBCzWnegyhZIHbg6Z7vVm8xDP
	Inkq01QT0wY+eqtxE+cW0GWuY/ErnMwfyP9Q8CoQo99jDpKKXD3VUlIfXpV2wVIQH15uDdsAH/7
	MAWQ231r8j1xTAVitP32NKUkTtk0=
X-Gm-Gg: ASbGncv0psT6mMdt7ikrIExwOCqjU0ssawb1sWvxLPxB9TCHl4rnK2xzrQEePybIEfm
	rC6/uZm9rkjRM0EYdhPJV1c83Xz96jaIulStjFQ==
X-Google-Smtp-Source: AGHT+IGfD4Sd3vaCQ8JL36C8pjFav+lEFwqjQoqQoTgPFpUkLuScTL38ICQVI8vc5U/qv8ggHPvSweB9yUpKgor9klU=
X-Received: by 2002:a17:90a:c888:b0:2f4:f7f8:fc8a with SMTP id
 98e67ed59e1d1-2f782d8cd4emr4334747a91.33.1737122955325; Fri, 17 Jan 2025
 06:09:15 -0800 (PST)
MIME-Version: 1.0
References: <20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
 <aeac8b24d43c57b7b426983ae50ec65680dafc24.camel@linuxfoundation.org>
 <CANNYZj9q6+D6AppzUbuV_cdMszt_KA3kfsamOtcRFxoWWFjV+A@mail.gmail.com>
 <513bf8f4-fb14-42dd-89fb-275e4b468924@weidmueller.com> <CANNYZj_z49bpc7fnvKO737La2YHy7zCPsgzwhS-G+=OQfi6uUQ@mail.gmail.com>
 <c164bf03-b00c-421e-a41c-441fe911eac5@weidmueller.com> <CANNYZj_-+uq0HmLYWAU1kEBPdkiCfyjkAu8cdSjxt6PsCB=-9A@mail.gmail.com>
 <7121dc06-215a-4481-be8e-7094a45e43ad@weidmueller.com> <CANNYZj_Ddh0zWbE79G5TAwQrU805WrrzDbjJTopT7EgLALBgQg@mail.gmail.com>
 <4f1f10ac-4a71-4b2b-9ea7-63e1da5d3e94@weidmueller.com> <CADkTA4MtLO90FW6YfeHDh7Lyo7=DRvxm6xf8Q0LkhC+u0U15iQ@mail.gmail.com>
 <1d86a392-db47-4fac-81fe-5262477bcd70@weidmueller.com> <CADkTA4PeRvBoR-F3pM-XOjWKEjsgLX+entDPv1uL+uTiFxjc=w@mail.gmail.com>
 <fbe116ef-f544-4d21-8b36-796fd6429811@weidmueller.com>
In-Reply-To: <fbe116ef-f544-4d21-8b36-796fd6429811@weidmueller.com>
From: Bruce Ashfield <bruce.ashfield@gmail.com>
Date: Fri, 17 Jan 2025 09:09:03 -0500
X-Gm-Features: AbW1kvavmp2LY12qRAh2l_Cs_GoPVlkcQBY4kb23opLho6rsndKMeVIHfzE-Vz4
Message-ID: <CADkTA4MBDjSODNmFM-WYNspUzGGgOKBAZpHKdLAHgxPyrV=ciQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [RFC PATCH 00/21] Concept for tightly coupled
 package manager (Node.js, Go, Rust)
To: stefan.herbrechtsmeier-oss@weidmueller.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000aef734062be77493"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Jan 2025 14:09:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17032

--000000000000aef734062be77493
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 2:45=E2=80=AFAM Stefan Herbrechtsmeier via
lists.openembedded.org <stefan.herbrechtsmeier-oss=3D
weidmueller.com@lists.openembedded.org> wrote:

> Am 17.01.2025 um 05:19 schrieb Bruce Ashfield via lists.openembedded.org:
>
> On Mon, Jan 13, 2025 at 2:11=E2=80=AFAM Stefan Herbrechtsmeier <
> stefan.herbrechtsmeier-oss@weidmueller.com> wrote:
>
>> Am 10.01.2025 um 21:24 schrieb Bruce Ashfield:
>>
>> On Fri, Jan 10, 2025 at 10:04=E2=80=AFAM Stefan Herbrechtsmeier via
>> lists.openembedded.org <stefan.herbrechtsmeier-oss=3D
>> weidmueller.com@lists.openembedded.org> wrote:
>>
>>> Am 10.01.2025 um 14:26 schrieb Alexander Kanavin:
>>>
>>> On Fri, 10 Jan 2025 at 12:32, Stefan Herbrechtsmeier<stefan.herbrechtsm=
eier-oss@weidmueller.com> <stefan.herbrechtsmeier-oss@weidmueller.com> wrot=
e:
>>>
>>> What is your opinion regarding gitsm. Should we remove the bitbake fetc=
her and use a update task to generate a inc file with the source uris and s=
ource revisions?
>>>
>>> That ship has sailed. We can't remove gitsm, it has users, and they
>>> will be very angry.
>>>
>>> This makes it impossible to fix wrong design decision or remove code
>>> with a low code quality.
>>>
>>> Do you really review the changes of the inc file?
>>> I understand the points but I have the feeling that they are more theor=
etically for package manager dependencies or could be solved in an other wa=
y (ex. caching)
>>>
>>> But do you? I have to restate the point: a solution that can be placed
>>> inside a layer is much more scalable and maintainable than adding code
>>> to bitbake. That's why I'm leaning towards drawing the line at
>>> existing fetchers that are wget/git convenience wrappers, and shifting
>>> dependency/lockfile management to layers. It's ultimately RP's call,
>>> but he does seek feedback :)
>>>
>>> I'm working on it.
>>>
>>> I'm fine with large SRC_URI/sha256 diffs when recipes get updated to
>>> new versions. And since you asked, no, no one looks at them, they're
>>> auto-generated noise that we learned to block out, just as we learned
>>> to quickly skim over recipe patch changes that are just line number
>>> churn and similar non-functional changes.
>>>
>>> Instead of an inc file the generated SRC_URIs could be saved inside the
>>> work directory of the recipe. This will eliminate the noise and avoid a
>>> manual run of an update task after a recipe changes.
>>>
>>
>> Except for those that want the .inc file changes to be version controlle=
d
>> (as well as SRC_URI changes), but maybe I'm misunderstanding what you
>> described above
>>
>> Why should somebody version control the generated SRC_URI?
>>
>>
>> Why wouldn't they ? I'm talking about when the SRC_URI is generated to
> git fetches (or whatever), that is part of the recipe and version
> controlled.
>
> My point is that this is not throw away / transient information for many
> use cases. It is something that can be tracked between updates to the
> recipes.
>
>
>
>> A generated temporary/build file is definitely more visible than
>> something that is programmatically done and held internally during recip=
e
>> processing and build.  It opens the door for extension and doing version
>> control on it.  So I don't object to the concept, I just don't think I h=
ave
>> all the details straight in my head.
>>
>> A generated build file will be saved in the work directory of the recipe
>> like any other generated build file. It is impossible to add it to the
>> version control system. The update task create a version controlled
>> generated source file. I don't understand why the version control is nee=
ded
>> because the source of the generator and the generator are version
>> controlled. Especially if the output is ignored during patch review. I
>> think it is much more straightforward to patch the source (lock file)
>> because it is complicated to handle manual changes during regeneration o=
f a
>> generated file.
>>
> *sigh*. I'm quite aware of what can and cannot be done. That's not what I
> meant. I'm obviously not talking about something in WORKDIR. I'm just
> saying that if something is written to disk, then depending on how things
> are implemented it can be viewed, debugged and manipulated. If it is alwa=
ys
> generated, held internally to the classes and used, I have no options to =
do
> that sort of debug. Similarly, anything that is generated, it would be
> ideal if there was a way to re-use a previously generated artifact and no=
t
> generate it on the fly .. that's the element that opens the door to versi=
on
> control and tracking.
>
> Why do we need to track the generated file if the source is version
> control and the generated file is cached like any other task output. I
> working on a prototype with the following steps:
>
> 1. Fetch the sources from the recipe (do_fetch)
> 2. Unpack the sources from the recipe (do_unpack)
> 2. Apply patches which are marked as early to patch the lock file
> (do_patch_early)
> 3. Resolve dependencies from the lock file and write it into a file
> (do_vendor_resolve)
>
4. Fetch dependencies (do_vendor_fetch)
> 5. Unpack dependencies into a package manager cache (do_vendor_unpack)
> 6. Create a vendor directory below the source folder (do_vendor)
> 7. Apply patches (do_patch)
>
I just track the vendor resolution over time. I've used it many times to
figure out what has gone wrong with the go recipes that I maintain when the
upstream repositories have done something odd with tags, etc, when I'm
doing recipe upgrades.

I use that same file to bump SRCREVs on the vendor dependency fetches when
picking upstream fixes, etc. because I'm typically working on dependencies
that don't have upstream releases that contain what I need and rather than
patch a vendor'd file, I just bump the individual dependency or point it
somewhere else (typically local to my machine) to fix the problem.
It's the workflow I've developed after needing to wade into very large go
recipes that went to go mod fetched vendor directories quite early on and
it ensured that I'm not relying on any proxies, infrastructure or much that
is hidden, so I'm able to debug, archive and be relatively sure that I can
keep things working over time. I'm not even remotely saying this workflow
is for everyone, I'm just trying to see if I could use some of this to
resolve those base fetches and be able to use the outputs of it (what I
currently have in .inc files) as part of my recipes.

The .inc files are the ones that have the fetches listed/resolved, and
those are the ones that are part of my recipe, so they are version
controlled along with the main recipe.

Cheers,

Bruce


> The go, rust and npm fetchers work. The go vendor folder works. I'm still
> working on the vendor directory for crate, a solution for npm without
> JavaScript and the integration of the dynamic sources into the SBOM,
> archiver and so on.
>
> Do you have a recommendation for an example project for the Rust, Go and
> npm fetcher?
>
> We'll agree to disagree on what is or isn't efficient or complicated.
> Luckily, this is all opt-in, so I'll never really have to use it. I'm jus=
t
> sharing what it would take to get me to consider it based on what I've
> learned/suffered in my time maintaining quite a few go recipes.
>
> My problem is to understand the reasons or use cases behind the inc for
> generated content and its version control. I understand that is must be
> possible to manipulate the fetches dependencies, to cache the generated
> fetcher URIs, to make the fetcher URIs viewable and to manipulate the
> fetched dependency sources.
>
> Regards
>   Stefan
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17022):
> https://lists.openembedded.org/g/bitbake-devel/message/17022
> Mute This Topic: https://lists.openembedded.org/mt/110212697/1050810
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> bruce.ashfield@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--=20
- Thou shalt not follow the NULL pointer, for chaos and madness await thee
at its end
- "Use the force Harry" - Gandalf, Star Trek II

--000000000000aef734062be77493
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote gmail_quote_con=
tainer"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jan 17, 2025 at 2:45=
=E2=80=AFAM Stefan Herbrechtsmeier via <a href=3D"http://lists.openembedded=
.org">lists.openembedded.org</a> &lt;stefan.herbrechtsmeier-oss=3D<a href=
=3D"mailto:weidmueller.com@lists.openembedded.org">weidmueller.com@lists.op=
enembedded.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex"><u></u>

 =20
  <div>
    <div>Am 17.01.2025 um 05:19 schrieb Bruce
      Ashfield via <a href=3D"http://lists.openembedded.org" target=3D"_bla=
nk">lists.openembedded.org</a>:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">
        <div class=3D"gmail_quote">
          <div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jan 13, 2025 at
            2:11=E2=80=AFAM Stefan Herbrechtsmeier &lt;<a href=3D"mailto:st=
efan.herbrechtsmeier-oss@weidmueller.com" target=3D"_blank">stefan.herbrech=
tsmeier-oss@weidmueller.com</a>&gt;
            wrote:<br>
          </div>
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <div>
              <div>Am 10.01.2025 um 21:24 schrieb Bruce Ashfield:<br>
              </div>
              <blockquote type=3D"cite">
                <div dir=3D"ltr">
                  <div class=3D"gmail_quote">
                    <div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jan 10,
                      2025 at 10:04=E2=80=AFAM Stefan Herbrechtsmeier via <=
a href=3D"http://lists.openembedded.org" target=3D"_blank">lists.openembedd=
ed.org</a>
                      &lt;stefan.herbrechtsmeier-oss=3D<a href=3D"mailto:we=
idmueller.com@lists.openembedded.org" target=3D"_blank">weidmueller.com@lis=
ts.openembedded.org</a>&gt;
                      wrote:<br>
                    </div>
                    <blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
                      <div>
                        <div>Am 10.01.2025 um 14:26 schrieb Alexander
                          Kanavin:<br>
                        </div>
                        <blockquote type=3D"cite">
                          <pre>On Fri, 10 Jan 2025 at 12:32, Stefan Herbrec=
htsmeier
<a href=3D"mailto:stefan.herbrechtsmeier-oss@weidmueller.com" target=3D"_bl=
ank">&lt;stefan.herbrechtsmeier-oss@weidmueller.com&gt;</a> wrote:
</pre>
                          <blockquote type=3D"cite">
                            <pre>What is your opinion regarding gitsm. Shou=
ld we remove the bitbake fetcher and use a update task to generate a inc fi=
le with the source uris and source revisions?
</pre>
                          </blockquote>
                          <pre>That ship has sailed. We can&#39;t remove gi=
tsm, it has users, and they
will be very angry.</pre>
                        </blockquote>
                        <p>This makes it impossible to fix wrong design
                          decision or remove code with a low code
                          quality.<br>
                          <span style=3D"white-space:pre-wrap">

</span></p>
                        <blockquote type=3D"cite">
                          <blockquote type=3D"cite">
                            <pre>Do you really review the changes of the in=
c file?
I understand the points but I have the feeling that they are more theoretic=
ally for package manager dependencies or could be solved in an other way (e=
x. caching)
</pre>
                          </blockquote>
                          <pre>But do you? I have to restate the point: a s=
olution that can be placed
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
                          <pre>I&#39;m fine with large SRC_URI/sha256 diffs=
 when recipes get updated to
new versions. And since you asked, no, no one looks at them, they&#39;re
auto-generated noise that we learned to block out, just as we learned
to quickly skim over recipe patch changes that are just line number
churn and similar non-functional changes.</pre>
                        </blockquote>
                        <p> Instead of an inc file the generated
                          SRC_URIs could be saved inside the work
                          directory of the recipe. This will eliminate
                          the noise and avoid a manual run of an update
                          task after a recipe changes.<br>
                          <span style=3D"white-space:pre-wrap"></span></p>
                      </div>
                    </blockquote>
                    <div><br>
                    </div>
                    <div>
                      <div style=3D"font-size:small">Except for those that
                        want the .inc file changes=C2=A0to be version
                        controlled (as well as SRC_URI changes), but
                        maybe I&#39;m misunderstanding what you described
                        above</div>
                    </div>
                  </div>
                </div>
              </blockquote>
              <p>Why should somebody version control the generated
                SRC_URI?<br>
              </p>
              <p><br>
              </p>
            </div>
          </blockquote>
          <div><span class=3D"gmail_default" style=3D"font-size:small">Why
              wouldn&#39;t they ? I&#39;m talking about when the SRC_URI is
              generated to git fetches (or whatever), that is part of
              the recipe and version controlled.<br>
            </span></div>
          <div><br>
          </div>
          <div>
            <div style=3D"font-size:small">My point
              is that this is not throw away / transient information for
              many use cases. It is something that can be tracked
              between updates to the recipes.</div>
            <br>
          </div>
          <div>=C2=A0</div>
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <div>
              <p> </p>
              <blockquote type=3D"cite">
                <div dir=3D"ltr">
                  <div class=3D"gmail_quote">
                    <div>
                      <div style=3D"font-size:small">A generated
                        temporary/build file is definitely more visible
                        than something that is programmatically done and
                        held internally during recipe processing and
                        build.=C2=A0 It opens the door for extension and
                        doing version control on it.=C2=A0 So I don&#39;t o=
bject
                        to the concept, I just don&#39;t think I have all
                        the details straight in my head.<br>
                      </div>
                    </div>
                  </div>
                </div>
              </blockquote>
              <p>A generated build file will be saved in the work
                directory of the recipe like any other generated build
                file. It is impossible to add it to the version control
                system. The update task create a version controlled
                generated source file. I don&#39;t understand why the
                version control is needed because the source of the
                generator and the generator are version controlled.
                Especially if the output is ignored during patch review.
                I think it is much more straightforward to patch the
                source (lock file) because it is complicated to handle
                manual changes during regeneration of a generated file.<br>
              </p>
            </div>
          </blockquote>
          <div><span class=3D"gmail_default" style=3D"font-size:small">*sig=
h*.
              I&#39;m quite aware of what can and cannot be done. That&#39;=
s not
              what I meant. I&#39;m obviously not talking about something i=
n
              WORKDIR. I&#39;m just saying that if something is written to
              disk, then depending on how things are implemented it can
              be viewed, debugged=C2=A0and manipulated. If it is always
              generated, held internally to the classes and used, I have
              no options to do that sort of debug. Similarly, anything
              that is generated, it would be ideal if there was a way to
              re-use=C2=A0a previously generated artifact and not generate =
it
              on the fly .. that&#39;s the element that opens the door to
              version control and tracking.</span></div>
        </div>
      </div>
    </blockquote>
    <p>Why do we need to track the generated file if the source is
      version control and the generated file is cached like any other
      task output. I working on a prototype with the following steps:<br>
    </p>
    <p>1. Fetch the sources from the recipe (do_fetch)<br>
      2. Unpack the sources from the recipe (do_unpack)<br>
      2. Apply patches which are marked as early to patch the lock file
      (do_patch_early)<br>
      3. Resolve dependencies from the lock file and write it into a
      file (do_vendor_resolve)=C2=A0</p></div></blockquote><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex"><div><p>
      4. Fetch dependencies (do_vendor_fetch)<br>
      5. Unpack dependencies into a package manager cache
      (do_vendor_unpack)<br>
      6. Create a vendor directory below the source folder (do_vendor)<br>
      7. Apply patches (do_patch)<br></p></div></blockquote><div><div class=
=3D"gmail_default" style=3D"font-size:small">I just track the vendor resolu=
tion over time. I&#39;ve used it many times to figure out what has gone wro=
ng with the go recipes that I maintain when the upstream repositories have =
done something odd with tags, etc, when I&#39;m doing recipe upgrades.</div=
><div class=3D"gmail_default" style=3D"font-size:small"><br></div><div clas=
s=3D"gmail_default" style=3D"font-size:small">I use that same file to bump =
SRCREVs on the vendor dependency fetches when picking upstream fixes, etc. =
because I&#39;m typically working on dependencies that don&#39;t have upstr=
eam releases that contain what I need and rather than patch a vendor&#39;d =
file, I just bump the individual dependency or point it somewhere else (typ=
ically local to my machine) to fix the problem.</div></div><div class=3D"gm=
ail_default" style=3D"font-size:small"></div><div class=3D"gmail_quote gmai=
l_quote_container"><div class=3D"gmail_default" style=3D"font-size:small">I=
t&#39;s the workflow I&#39;ve developed after needing to wade into very lar=
ge go recipes that went to go mod fetched vendor directories quite early on=
 and it ensured that I&#39;m not relying on any proxies, infrastructure or =
much that is hidden, so I&#39;m able to debug, archive and be relatively su=
re that I can keep things working over time. I&#39;m not even remotely sayi=
ng this workflow is for everyone, I&#39;m just trying to see if I could use=
 some of this to resolve those base fetches and be able to use the outputs =
of it (what I currently have in .inc files) as part of my recipes.=C2=A0</d=
iv><div class=3D"gmail_default" style=3D"font-size:small"><br></div><div cl=
ass=3D"gmail_default" style=3D"font-size:small">The .inc files are the ones=
 that have the fetches listed/resolved, and those are the ones that are par=
t of my recipe, so they are version controlled along with the main recipe.<=
/div><div class=3D"gmail_default" style=3D"font-size:small"><br></div><div =
class=3D"gmail_default" style=3D"font-size:small">Cheers,</div><div class=
=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D"gmail_=
default" style=3D"font-size:small">Bruce</div></div><br><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><div><p>
      <br>
      The go, rust and npm fetchers work. The go vendor folder works.
      I&#39;m still working on the vendor directory for crate, a solution
      for npm without JavaScript and the integration of the dynamic
      sources into the SBOM, archiver and so on.</p>
    <p>Do you have a recommendation for an example project for the Rust,
      Go and npm fetcher?<br>
      <br>
    </p>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div class=3D"gmail_quote">
          <div>
            <div style=3D"font-size:small">We&#39;ll
              agree to disagree on what is or isn&#39;t efficient or
              complicated. Luckily, this is all opt-in, so I&#39;ll never
              really have to use it. I&#39;m just sharing what it would tak=
e
              to get me to consider it based on what I&#39;ve
              learned/suffered in my time maintaining=C2=A0quite a few go
              recipes.<br>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <p>My problem is to understand the reasons or use cases behind the
      inc for generated content and its version control. I understand
      that is must be possible to manipulate the fetches dependencies,
      to cache the generated fetcher URIs, to make the fetcher URIs
      viewable and to manipulate the fetched dependency sources.<br>
      <br>
      Regards<br>
      =C2=A0 Stefan<br>
      <br>
      <span style=3D"white-space:pre-wrap">
</span></p>
  </div>

<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#17022): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/17022" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/17022</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/110212697/105=
0810" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/110212697/1050810</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:bruce.ashfield@gmail.com" target=
=3D"_blank">bruce.ashfield@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature">- Thou shalt not follow the NULL pointer, for chaos and madness a=
wait thee at its end<br>- &quot;Use the force Harry&quot; - Gandalf, Star T=
rek II<br><br></div></div>

--000000000000aef734062be77493--

