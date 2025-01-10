Return-Path: <bruce.ashfield@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE3BE77188
	for <webhook@archiver.kernel.org>; Fri, 10 Jan 2025 20:24:31 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.web10.1044.1736540663691253271
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Jan 2025 12:24:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=kTkQlN0/;
 spf=pass (domain: gmail.com, ip: 209.85.216.47, mailfrom: bruce.ashfield@gmail.com)
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ee9a780de4so3189653a91.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 Jan 2025 12:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736540663; x=1737145463; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5LEK1a4pKZ2gmo/umXm+suCUcZS5Tqa0uO8nXArE5fQ=;
        b=kTkQlN0/9Z5NDL0KlKGRZwkxvszxWGrp5ouXteeJQX9BLQu6ZXw2q5s6rKKHnHNKaJ
         kjaRHB8bUg4ezxmRvud2Z9BCcuQJtOfFsURgmCL2AiIAes+Mp1+KA4LIUPaQCrn6+Mi4
         /gQgHtr5o5icjZTf5oUpZrEnafoyBSm5yQ5e6LOA06QQJU0R0PZxP3K5GrHVxp2qEc8N
         P7Lj3xBp2/hTsveM+VnpU2+idurYMwlZCWJ7+qTfQR6aFX0WJCu2ha3mH6G7dqRuVHDi
         Q3ZrrgFBhgy5/qmJaJwvv7OCFomZ7sjNZ875L1+ls+leE5jDslQU7a44eBmzTL5vjAHO
         TCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736540663; x=1737145463;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5LEK1a4pKZ2gmo/umXm+suCUcZS5Tqa0uO8nXArE5fQ=;
        b=wzYdHSFJCCk2h7hefgNaYBFvKA75xqvUmCL4kitvCoSi2uvOFd8m3ndm/f9OEhMjbF
         Y12yWf2aDw1GHOj6WRPBiRr1wQZ3G5MuooJojFWvDlWk+PdlcD291pEqh5qmS+UYbw+W
         zzjk1lIoyOxvRe81fsVImlr0a5kxBbH833c7ff1ms1nPV2+2TSSL4D7ZzDRfdcZ5ziux
         Nhm6c74iFFYh8xd9svfCHG5+O3J3vBwriZy7jul61GtmmFjwU2RpB/YPwS61mrG7aJdV
         AXg3nToNjyrAB4K1SZQckVv7+ljFnQTtMUYQu8QR27xPYcOT7VHpbAt8JTAIJds/+oh/
         MJVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUP2GJRQxAuF9zQ/2U8fPNs7Os04W6tYIJb1yJTPgBFU8PuLw2AKJx0j5EDXnsSOuUpjZ581+C2qIaqBKNp@lists.openembedded.org
X-Gm-Message-State: AOJu0Yzx/562lv2XN4yEaw6cHqpXNJQ0hxQ3/toHhUX9WL4+69P90XQ5
	vSTz9hYKGm97Ldc3aX21b98xwVZ/1KTHUJy23JV1BaEdBJKG3OGZyqDaVYsKCvas3Laq3RnDgMm
	IgGdiGY7cj8pg4gv/GE2oJMh3jsA=
X-Gm-Gg: ASbGncv+YAJTGYHENvKqMKH1tnqP87v3tMJomBLsKrdTx4mnXuwcRW8QqpKO09oPt5g
	xbax+/LH8zaWNd7gfRbeNDd3gGXOlltCoXXdqlg==
X-Google-Smtp-Source: AGHT+IEMBjNLhx5rh7XkxWxbZIIWTn3PEml9CaYJmXGzWtzighNftc1u6G4F7NMHr7rtTm/QQeAhQ+UQvJACzr/pIHc=
X-Received: by 2002:a17:90a:d00b:b0:2ee:d63f:d8f with SMTP id
 98e67ed59e1d1-2f548ebf53cmr17023736a91.13.1736540662947; Fri, 10 Jan 2025
 12:24:22 -0800 (PST)
MIME-Version: 1.0
References: <20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
 <aeac8b24d43c57b7b426983ae50ec65680dafc24.camel@linuxfoundation.org>
 <CANNYZj9q6+D6AppzUbuV_cdMszt_KA3kfsamOtcRFxoWWFjV+A@mail.gmail.com>
 <513bf8f4-fb14-42dd-89fb-275e4b468924@weidmueller.com> <CANNYZj_z49bpc7fnvKO737La2YHy7zCPsgzwhS-G+=OQfi6uUQ@mail.gmail.com>
 <c164bf03-b00c-421e-a41c-441fe911eac5@weidmueller.com> <CANNYZj_-+uq0HmLYWAU1kEBPdkiCfyjkAu8cdSjxt6PsCB=-9A@mail.gmail.com>
 <7121dc06-215a-4481-be8e-7094a45e43ad@weidmueller.com> <CANNYZj_Ddh0zWbE79G5TAwQrU805WrrzDbjJTopT7EgLALBgQg@mail.gmail.com>
 <4f1f10ac-4a71-4b2b-9ea7-63e1da5d3e94@weidmueller.com>
In-Reply-To: <4f1f10ac-4a71-4b2b-9ea7-63e1da5d3e94@weidmueller.com>
From: Bruce Ashfield <bruce.ashfield@gmail.com>
Date: Fri, 10 Jan 2025 15:24:11 -0500
X-Gm-Features: AbW1kvZYEaxOqua9q9OEcM6tTyBosC3itG7PIiq6962rzqpJd6QWXWU6MNjhR-4
Message-ID: <CADkTA4MtLO90FW6YfeHDh7Lyo7=DRvxm6xf8Q0LkhC+u0U15iQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [RFC PATCH 00/21] Concept for tightly coupled
 package manager (Node.js, Go, Rust)
To: stefan.herbrechtsmeier-oss@weidmueller.com
Cc: Alexander Kanavin <alex.kanavin@gmail.com>, richard.purdie@linuxfoundation.org, 
	bitbake-devel@lists.openembedded.org, 
	Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Content-Type: multipart/alternative; boundary="0000000000005a66a4062b5fe19a"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Jan 2025 20:24:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17010

--0000000000005a66a4062b5fe19a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 10:04=E2=80=AFAM Stefan Herbrechtsmeier via
lists.openembedded.org <stefan.herbrechtsmeier-oss=3D
weidmueller.com@lists.openembedded.org> wrote:

> Am 10.01.2025 um 14:26 schrieb Alexander Kanavin:
>
> On Fri, 10 Jan 2025 at 12:32, Stefan Herbrechtsmeier<stefan.herbrechtsmei=
er-oss@weidmueller.com> <stefan.herbrechtsmeier-oss@weidmueller.com> wrote:
>
> What is your opinion regarding gitsm. Should we remove the bitbake fetche=
r and use a update task to generate a inc file with the source uris and sou=
rce revisions?
>
> That ship has sailed. We can't remove gitsm, it has users, and they
> will be very angry.
>
> This makes it impossible to fix wrong design decision or remove code with
> a low code quality.
>
> Do you really review the changes of the inc file?
> I understand the points but I have the feeling that they are more theoret=
ically for package manager dependencies or could be solved in an other way =
(ex. caching)
>
> But do you? I have to restate the point: a solution that can be placed
> inside a layer is much more scalable and maintainable than adding code
> to bitbake. That's why I'm leaning towards drawing the line at
> existing fetchers that are wget/git convenience wrappers, and shifting
> dependency/lockfile management to layers. It's ultimately RP's call,
> but he does seek feedback :)
>
> I'm working on it.
>
> I'm fine with large SRC_URI/sha256 diffs when recipes get updated to
> new versions. And since you asked, no, no one looks at them, they're
> auto-generated noise that we learned to block out, just as we learned
> to quickly skim over recipe patch changes that are just line number
> churn and similar non-functional changes.
>
> Instead of an inc file the generated SRC_URIs could be saved inside the
> work directory of the recipe. This will eliminate the noise and avoid a
> manual run of an update task after a recipe changes.
>

Except for those that want the .inc file changes to be version controlled
(as well as SRC_URI changes), but maybe I'm misunderstanding what you
described above

A generated temporary/build file is definitely more visible than something
that is programmatically done and held internally during recipe processing
and build.  It opens the door for extension and doing version control on
it.  So I don't object to the concept, I just don't think I have all the
details straight in my head.

Cheers,

Bruce

Even if we put all license information inside the inc file. Who should
review the changes ? What tooling is used to review the change
(license content)? If we blindly trust the inc file generator, the inc
file is useless and we can generate the information on-the-fly.
>
> We won't blindly trust a generator. There are multiple gate-keeping
> steps, some of which already work, and some should still be
> implemented:
>
> - when creating a recipe with devtool, devtool should discover all
> licenses and generate appropriate recipe metadata. For classic unix-y
> components this has to rely on 'guessing', but things like crates have
> deterministic licensing metadata (a field in Cargo.toml, and LICENSE-*
> files if I remember right). We can also propose adding such
> determinism upstream if it's not currently good enough.
>
> - when updating a recipe with devtool to a new upstream release, it
> uses the file:// entries in LIC_FILES_CHKSUM to generate a diff of
> previous license texts and the new ones, and writes that as a comment
> into the updated recipe. The diff is reviewed by a human performing
> the update, and condensed into an update to the LICENSE field (if
> needed), and an explanation of what changed in the License-Update tag
> in the commit message. This could be further automated if upstream has
> deterministic ways to specify licenses, e.g. LICENSE =3D
> "&".join(all_license_ids).
>
> - when sending the resulting patch for review, there's a mailing list
> bot (patchtest), which will check that any update in license checksums
> is accompanied by an explanation in License-Update tag. There are also
> humans which will check that the licensing changes are sensible.
> Otherwise we do trust that submitters spot important changes in
> licensing (from the diff in the previous step or by manual comparison,
> if they want) and summarise them in LICENSE correctly.
>
> - finally there are various license checks that run in recipe_qa task
> and implemented in insane.bbclass. They could be extended to verify
> that every dependency has a matching license entry in the recipe and
> so on. Anything that can be caught by looking at the source tree and
> the license metadata.
>
> This works for individual project but become complicated for dependencies
> because you have to handle the same change multiple times. But lets stop
> the discussion for now because license is out of scope of this series.
>
> Nevertheless I will move my implementation to oe-core and add a task to g=
enerate an inc file as starting point.
>
> That would be much appreciated. The more I think about it the more I'm
> convinced we should have it standardized in core.
>
> What do you mean by standardized?
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17006):
> https://lists.openembedded.org/g/bitbake-devel/message/17006
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

--0000000000005a66a4062b5fe19a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote gmail_quote_con=
tainer"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jan 10, 2025 at 10:04=
=E2=80=AFAM Stefan Herbrechtsmeier via <a href=3D"http://lists.openembedded=
.org">lists.openembedded.org</a> &lt;stefan.herbrechtsmeier-oss=3D<a href=
=3D"mailto:weidmueller.com@lists.openembedded.org">weidmueller.com@lists.op=
enembedded.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex"><u></u>

 =20
  <div>
    <div>Am 10.01.2025 um 14:26 schrieb
      Alexander Kanavin:<br>
    </div>
    <blockquote type=3D"cite">
      <pre>On Fri, 10 Jan 2025 at 12:32, Stefan Herbrechtsmeier
<a href=3D"mailto:stefan.herbrechtsmeier-oss@weidmueller.com" target=3D"_bl=
ank">&lt;stefan.herbrechtsmeier-oss@weidmueller.com&gt;</a> wrote:
</pre>
      <blockquote type=3D"cite">
        <pre>What is your opinion regarding gitsm. Should we remove the bit=
bake fetcher and use a update task to generate a inc file with the source u=
ris and source revisions?
</pre>
      </blockquote>
      <pre>That ship has sailed. We can&#39;t remove gitsm, it has users, a=
nd they
will be very angry.</pre>
    </blockquote>
    <p>This makes it impossible to fix wrong design decision or remove
      code with a low code quality.<br>
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
      <pre>But do you? I have to restate the point: a solution that can be =
placed
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
      <pre>I&#39;m fine with large SRC_URI/sha256 diffs when recipes get up=
dated to
new versions. And since you asked, no, no one looks at them, they&#39;re
auto-generated noise that we learned to block out, just as we learned
to quickly skim over recipe patch changes that are just line number
churn and similar non-functional changes.</pre>
    </blockquote>
    <p> Instead of an inc file the generated SRC_URIs could be saved
      inside the work directory of the recipe. This will eliminate the
      noise and avoid a manual run of an update task after a recipe
      changes.<br>
      <span style=3D"white-space:pre-wrap"></span></p></div></blockquote><d=
iv><br></div><div><div class=3D"gmail_default" style=3D"font-size:small">Ex=
cept for those that want the .inc file changes=C2=A0to be version controlle=
d (as well as SRC_URI changes), but maybe I&#39;m misunderstanding what you=
 described above</div><div class=3D"gmail_default" style=3D"font-size:small=
"><br></div><div class=3D"gmail_default" style=3D"font-size:small">A genera=
ted temporary/build file is definitely more visible than something that is =
programmatically done and held internally during recipe processing and buil=
d.=C2=A0 It opens the door for extension and doing version control on it.=
=C2=A0 So I don&#39;t object to the concept, I just don&#39;t think I have =
all the details straight in my head.</div></div><div><br></div><div><div cl=
ass=3D"gmail_default" style=3D"font-size:small">Cheers,</div><div class=3D"=
gmail_default" style=3D"font-size:small"><br></div><div class=3D"gmail_defa=
ult" style=3D"font-size:small">Bruce</div><br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex"><div><p><span style=3D"white-space:pre-wrap">

</span></p>
    <blockquote type=3D"cite">
      <blockquote type=3D"cite">
        <pre>Even if we put all license information inside the inc file. Wh=
o should review the changes ? What tooling is used to review the change (li=
cense content)? If we blindly trust the inc file generator, the inc file is=
 useless and we can generate the information on-the-fly.
</pre>
      </blockquote>
      <pre>We won&#39;t blindly trust a generator. There are multiple gate-=
keeping
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
    This works for individual project but become complicated for
    dependencies because you have to handle the same change multiple
    times. But lets stop the discussion for now because license is out
    of scope of this series.<br>
    <br>
    <blockquote type=3D"cite">
      <blockquote type=3D"cite">
        <pre>Nevertheless I will move my implementation to oe-core and add =
a task to generate an inc file as starting point.
</pre>
      </blockquote>
      <pre>That would be much appreciated. The more I think about it the mo=
re I&#39;m
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
View/Reply Online (#17006): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/17006" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/17006</a><br>
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

--0000000000005a66a4062b5fe19a--

