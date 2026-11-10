Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5246.1794351225813819424
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 Nov 2026 14:53:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=PaOcF1Uf;
 spf=pass (domain: gmail.com, ip: 209.85.128.178, mailfrom: jpewhacker@gmail.com)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8b331cad3cfso21324117b3.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 10 Nov 2026 14:53:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794351225; cv=none;
        d=google.com; s=arc-20260327;
        b=Kxpo42i0qE7hZV0wCv7YYeKeh1vwgEqPYqPoFZl9E01nYgFiuIU3FDTpgqcRWIHPKb
         cYemI1/9LYx3KBjVdfQpax7u5o+WOBiBAEL2ZrWt1wPw01eaoMuEG1mV44OamQx5yOJ4
         aXwIYJINRjmiEle7hic1S0o/0gKdWhjuR4JpJbrAvVo9ZyNuUwH1tGqC21mI1AdkIKlB
         uMvQ8iHe0e8nnJCBB9AORUs0QE2PoFRUVm98YPtQMawinyMimQeYCWB8+xC90unZRtpX
         yWDjnTHccsxhontSPTgBf+1ueQ0Qv7p6DSanzdwGHrBPHM3fpL0A3ifXrA94kiV4BjZF
         mv9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7yeIw2tLfnYRlcPL5xsgNyXIHvfRI9zJWlDf1YejCRs=;
        fh=KeqhLj9Ek/kkG4h1woe1Nc7VpJZc0k3BCA/jOuEHfw4=;
        b=MfIXCFt9ik1jnMKnzMAq0ws/rN1Z6Gng3qU1QU3i9BSTHobHff4PuW1X3xBaGVgs+Y
         16wIzo1GKgjgnbT8zfcBpbT6mUXQ87cnx+4TI2e0d+yfg3UIbeZoPTfJixqzT2poxFtu
         dAP4w6me2a1eMGwjTQg6Pp3DTdA7TToO6AIMqAjV3kjb89Dxd5r7rqEga9TWswsvRKhL
         ZlXul4mdPCtgZ/v5rUepGG8r2L5k2F1gWPVNTmrP4logr2fmeS5NuU7X0BB23npqh/RT
         2EMc/3hmTl9NT8lDL/8Ch/+QutiVTRZ2UHbWAbVRvpaRQ/CaGMgMr/3efsdmpdcBvrrs
         32ZA==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794351225; x=1794956025; darn=lists.openembedded.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7yeIw2tLfnYRlcPL5xsgNyXIHvfRI9zJWlDf1YejCRs=;
        b=PaOcF1Uf4cIKReRcydHyflMipr+gpg95+iDEShFlAxfOO1VVpwh6L8NJRcEjj4J//4
         0lYGHQMrPSWlk1G9yiwbbeIBQHyPB52Em/5fevlPcV4rIAm3xMQYyRFwyQ1oGWn+lT62
         6E5RyJrZjVIjEcH+3r5L/6R02UnBJhMa4DgJl0LXy1cNRcbUriLnntA2m8qQEeexoRYG
         NlWK+w2/7eqO5NYdy73Mxc1zpokBMVGzI1Ywtp8RRwoUsMw0zGGGiBhoLCXQ9tO0k9yq
         IuDvMkn059qIJ6wYiWpihBkQl5br+J+c3ePVEBWI7kbpQLbtboTqY/F8eruPTQC4bDcn
         5wxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794351225; x=1794956025;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7yeIw2tLfnYRlcPL5xsgNyXIHvfRI9zJWlDf1YejCRs=;
        b=lkZR29F9NoeBAG7EebtZVWonY2wImAmEjOR763mp3hgIqFPWT7rNrV35WBf54NGPnr
         sYWoPb1lp0frr1rE46hHHcr/HsRYKjvoUCUVfL9iQN0UMcqObkrJ3rvkhguwPwMztZVG
         sCqQpbxr0nezbAx4T9N6Z3JMFLo2xDv41DofwnsNxMUzehqLOeqXtgfGAzeGLJFECeqY
         8D6tEQIxpmsj2IcbTiE+1swb4cW10+BYDH8jJeYZmagaIIETImne8LRs8yej3/fQDVu2
         4G8wOGp+Hc2Q6kqVXMVzXqXzsgGo3DyXUpB6iLVFD/IVpP+U8C/8dwefiJWAfCPNx4IK
         gCLw==
X-Forwarded-Encrypted: i=1; AL+hErEAcaSgKkQTBUpJ2zgwlRmjCHXl/FT2xRwGN4NMDVUI47/3bcCdTmCDkZjLfBWBs1y4pu4Eb3UhDAAzkXiX@lists.openembedded.org
X-Gm-Message-State: APuU4Z+gbuxwCt8H+3/BV7O8M8g/18gQycolAwIZ5OrgBZulCrmvjeWx
	YkTt7cHskTQOnW7QthTKohUNEMYcALCjpmpqkGa2bjm5bUtqH2DrPUG1zGzsXHVByc9jPR03/7A
	s39kGAe4uuWVpZZ5ltpb9jGTUVQg05iA=
X-Gm-Gg: AYBFou0g5uz+0m6jOmAPyfoN5JkRgL0ZMFwbx1o3327pQtz6PvIpp/zVUoVDMbxIz/3
	14LjscmcwR0LgLlXTtB5dYS+ls8qwOwvTO0/RosdUPqIrxs0e7pNYv1056Bz4vEynsX12/X7RVw
	x3N+ePvWMqoXMxe0Fju6LoQ4XBGzX207FZ/J63LGrl8Lg44hWHGErTYKwRfTuGdv9k8W3okCf1w
	6HpNNFaOrVEc9b+iS7T4aBUgxU9dJd6mVUxejfHTmHISDqSZTlUgFxu07E1GvDcmOgqowyFx37e
	UxOZwwnsSffqOxyqOpSSt3TMNprZqVFfMzZ7MDfNnyWQ9mtO6aYM6Q0d9HiHnjwzldXaI3/YjZ1
	PPoEuDL+UhoYbhny2rv4/Ea7yQvcm8MtaMyJbcFy9ZLpwI4un8wFMvUeicz4ziYhZIje+GoV+
X-Received: by 2002:a05:690e:13ca:b0:679:8bed:24cc with SMTP id
 956f58d0204a3-67c6804476emr570375d50.104.1794351224812; Tue, 10 Nov 2026
 14:53:44 -0800 (PST)
MIME-Version: 1.0
References: <87910dcc110b0e4cc397d9f57d9b37824c6859f2.camel@linuxfoundation.org>
 <20261110215935.107339-1-stondo@gmail.com>
In-Reply-To: <20261110215935.107339-1-stondo@gmail.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Tue, 10 Nov 2026 15:53:33 -0700
X-Gm-Features: AclHuK8jkgy3YJYZiSuIz9Iko2qH2KUZLkm8L0yPdAE7fWxIBUrSgdedfERiuzk
Message-ID: <CAJdd5GZTCwr9VE8OmOw7RAki+Xu+kokCgtOHG+9ghE3frWPbqg@mail.gmail.com>
Subject: Re: [RFC] spdx30: name, version and purl for dependency downloads
To: Stefano Tondo <stondo@gmail.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, stefano.tondo.ext@siemens.com, 
	Alexander Kanavin <alex.kanavin@gmail.com>, openembedded-core@lists.openembedded.org, 
	bitbake-devel@lists.openembedded.org, 
	Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>, 
	Peter Marko <peter.marko@siemens.com>, Adrian Freihofer <adrian.freihofer@siemens.com>, 
	Patrick Wicki <patrick.wicki@siemens.com>
Content-Type: multipart/alternative; boundary="0000000000005b782f065ff3f3c4"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Tue, 10 Nov 2026 22:53:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20416

--0000000000005b782f065ff3f3c4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 2:59=E2=80=AFPM Stefano Tondo <stondo@gmail.com> wr=
ote:

> Hi Richard, hi Alex,
>
> Thank you both for the feedback. Your replies point in the same
> direction, so I answer them together here.
>
> On Fri, 6 Nov 2026 at 12:04, Alexander Kanavin wrote:
> > - do not make fetchers any more complex than they already are.
> > [...] Rather try to do as much as possible in oe-core through a
> > clear API.
>
> On Fri, 6 Nov 2026 at 12:17, Richard Purdie wrote:
> > I think that the fetcher is the right place to do this as I would
> > be very much against poking fetcher internals from OE-Core. We need
> > to declare and document the stage at which this is expected to work
> > (i.e. before/after fetch, before/after unpack).
> > [...]
> > It should probably return structured data including the purl from
> > some new API.
>
> I think these two points fit together. The fetchers already parse the
> name and the version of each dependency for their own use. The new
> API only returns that data as a documented structure, with the purl.
> It does not change the fetch or the unpack. oe-core then writes
> the SPDX from it and does not read any fetcher internals.
>
> About the stage: crate, gomod and npmsw know the identity when they
> create the FetchData. That is before fetch, and it needs no network
> access. npmsw only reads its shrinkwrap file, which is a local file
> in the layer. gitsm is the exception, because it can list the
> submodules only from the clone. When the submodules are in SRC_URI,
> that exception goes away. So I propose to document "before fetch".
>
> > I am thinking we should change the fetcher so all the submodule urls
> > are included in SRC_URI in future and expanded_urldata() goes away.
> > We need to update the other backends to match. I have no knowledge
> > of npm so that one will be hard for me.
>
> Alex wrote:
> > - gitsm and npmsw are historical mistakes, however 'convenient' they
> > may be. [...] I would want to replace them with flat, explicit
> > implementations.
>
> I agree, and I would like to help with npm. My idea is to follow
> cargo-update-recipe-crates and go-mod-update-modules: an update class
> writes one SRC_URI entry with a checksum for each package in the
> shrinkwrap file. Then bitbake checks that the list matches the
> shrinkwrap file, as you said in your reply. Is
> that what you have in mind? If yes, I can prepare patches.
>
> This also makes my RFC smaller. Its first part records implicit
> downloads. With flat SRC_URI lists, there are no implicit downloads
> left to record.
>
> > We should revisit that and fix it as I think it exposes general
> > bugs.
>
> I can investigate this too. I have a reproducer that fails every time:
> meta-selftest's git-submodule-test with a named SRCREV. The bug I
> found is in Fetch.localpath() for a URL that is not in SRC_URI. It
> creates a new FetchData with the recipe datastore, which does not
> have the SRCREV that gitsm set for the submodule. Is this the bug you
> mean, or do you know of others in this area? I can start from any
> cases you have.
>
> > If the fetcher can conform to our APIs and roughly follow how
> > rust/crates are working today, I think those would be fine,
> > particularly if we have good tests too.
>
> Thanks, that is clear. I will come back to new fetchers only after
> we agree on the API.
>
> Joshua, Richard deferred question d) to you. In short: a lock file
> lists packages for all platforms, so the fetcher downloads some
> dependencies that are never built for the target. I proposed to take
> the declared scope from the lock file in the fetcher, and the
> observed scope from the language classes (for example cargo metadata
> --filter-platform). Does that split work for you? And how do you want
> "fetched but not built" to look in SPDX 3.0?
>

I'm not sure if we can. The current support we have is that the things
listed in SRC_URI are "build inputs" to the build, which is accurate (they
are inputs, even if they aren't used). We don't currently have a mechanism
to link the outputs of the build back to the SRC_URI inputs.

Perhaps, the better option would be to propagate the SRC_URI purls to the
output packages, but apply some sort of (optional) filter that can remove a
SRC_URI if it is not actually present in the output. That way, if we have
positive confirmation that some input is not present in the output, we can
remove its PURL from the output package (but, barring that, we include it).


>
> For the next step: crate and gomod already list every dependency in
> SRC_URI, so the identity API can work for them now. Do you want me to
> send patches for these two, with tests, and add npm after the
> flattening? Or do you prefer that I wait for Joshua's answer first?
>
> Thanks,
> Stefano
>

--0000000000005b782f065ff3f3c4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Nov 10,=
 2026 at 2:59=E2=80=AFPM Stefano Tondo &lt;<a href=3D"mailto:stondo@gmail.c=
om">stondo@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">Hi Richard, hi Alex,<br>
<br>
Thank you both for the feedback. Your replies point in the same<br>
direction, so I answer them together here.<br>
<br>
On Fri, 6 Nov 2026 at 12:04, Alexander Kanavin wrote:<br>
&gt; - do not make fetchers any more complex than they already are.<br>
&gt; [...] Rather try to do as much as possible in oe-core through a<br>
&gt; clear API.<br>
<br>
On Fri, 6 Nov 2026 at 12:17, Richard Purdie wrote:<br>
&gt; I think that the fetcher is the right place to do this as I would<br>
&gt; be very much against poking fetcher internals from OE-Core. We need<br=
>
&gt; to declare and document the stage at which this is expected to work<br=
>
&gt; (i.e. before/after fetch, before/after unpack).<br>
&gt; [...]<br>
&gt; It should probably return structured data including the purl from<br>
&gt; some new API.<br>
<br>
I think these two points fit together. The fetchers already parse the<br>
name and the version of each dependency for their own use. The new<br>
API only returns that data as a documented structure, with the purl.<br>
It does not change the fetch or the unpack. oe-core then writes<br>
the SPDX from it and does not read any fetcher internals.<br>
<br>
About the stage: crate, gomod and npmsw know the identity when they<br>
create the FetchData. That is before fetch, and it needs no network<br>
access. npmsw only reads its shrinkwrap file, which is a local file<br>
in the layer. gitsm is the exception, because it can list the<br>
submodules only from the clone. When the submodules are in SRC_URI,<br>
that exception goes away. So I propose to document &quot;before fetch&quot;=
.<br>
<br>
&gt; I am thinking we should change the fetcher so all the submodule urls<b=
r>
&gt; are included in SRC_URI in future and expanded_urldata() goes away.<br=
>
&gt; We need to update the other backends to match. I have no knowledge<br>
&gt; of npm so that one will be hard for me.<br>
<br>
Alex wrote:<br>
&gt; - gitsm and npmsw are historical mistakes, however &#39;convenient&#39=
; they<br>
&gt; may be. [...] I would want to replace them with flat, explicit<br>
&gt; implementations.<br>
<br>
I agree, and I would like to help with npm. My idea is to follow<br>
cargo-update-recipe-crates and go-mod-update-modules: an update class<br>
writes one SRC_URI entry with a checksum for each package in the<br>
shrinkwrap file. Then bitbake checks that the list matches the<br>
shrinkwrap file, as you said in your reply. Is<br>
that what you have in mind? If yes, I can prepare patches.<br>
<br>
This also makes my RFC smaller. Its first part records implicit<br>
downloads. With flat SRC_URI lists, there are no implicit downloads<br>
left to record.<br>
<br>
&gt; We should revisit that and fix it as I think it exposes general<br>
&gt; bugs.<br>
<br>
I can investigate this too. I have a reproducer that fails every time:<br>
meta-selftest&#39;s git-submodule-test with a named SRCREV. The bug I<br>
found is in Fetch.localpath() for a URL that is not in SRC_URI. It<br>
creates a new FetchData with the recipe datastore, which does not<br>
have the SRCREV that gitsm set for the submodule. Is this the bug you<br>
mean, or do you know of others in this area? I can start from any<br>
cases you have.<br>
<br>
&gt; If the fetcher can conform to our APIs and roughly follow how<br>
&gt; rust/crates are working today, I think those would be fine,<br>
&gt; particularly if we have good tests too.<br>
<br>
Thanks, that is clear. I will come back to new fetchers only after<br>
we agree on the API.<br>
<br>
Joshua, Richard deferred question d) to you. In short: a lock file<br>
lists packages for all platforms, so the fetcher downloads some<br>
dependencies that are never built for the target. I proposed to take<br>
the declared scope from the lock file in the fetcher, and the<br>
observed scope from the language classes (for example cargo metadata<br>
--filter-platform). Does that split work for you? And how do you want<br>
&quot;fetched but not built&quot; to look in SPDX 3.0?<br></blockquote><div=
><br></div><div>I&#39;m not sure if we can. The current support we have is =
that the things listed in SRC_URI are &quot;build inputs&quot; to the build=
, which is accurate (they are inputs, even if they aren&#39;t used). We don=
&#39;t currently have a mechanism to link the outputs of the build back to =
the SRC_URI inputs.</div><div><br></div><div>Perhaps, the better option wou=
ld be to propagate the SRC_URI purls to the output packages, but apply some=
 sort of (optional) filter that can remove a SRC_URI if it is not actually =
present in the output. That way, if we have positive confirmation that some=
 input is not present in the output, we can remove its PURL from the output=
 package (but, barring that, we include it).</div><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
<br>
For the next step: crate and gomod already list every dependency in<br>
SRC_URI, so the identity API can work for them now. Do you want me to<br>
send patches for these two, with tests, and add npm after the<br>
flattening? Or do you prefer that I wait for Joshua&#39;s answer first?<br>
<br>
Thanks,<br>
Stefano<br>
</blockquote></div></div>

--0000000000005b782f065ff3f3c4--
