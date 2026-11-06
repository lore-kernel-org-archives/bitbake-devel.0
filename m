Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4824.1793967451106633719
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 06 Nov 2026 04:17:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Mi891g+L;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a20a37703bso3874985e9.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 06 Nov 2026 04:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1793967449; x=1794572249; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=XAdaVTf2Gk3N+o83J6FnU/JwEUQwMwprkOgj3gzr/r8=;
        b=Mi891g+LW3PvfOIoyG7WrQgM9brktvLEBMMMAJUkNHUKM2hPAPVFipVO4Ewk6S9LPR
         nJOgB3iTzsKix86vHIciUWK2DaWoqi0bYYgohr1dFs1Z/VJddnMgJp/o5pAgr+44SwYH
         Jt7tyjN6Sz4Zg3D5AjdWMQVhKNXulxF9ivls8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793967449; x=1794572249;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XAdaVTf2Gk3N+o83J6FnU/JwEUQwMwprkOgj3gzr/r8=;
        b=mWgMvBAV5uJA/jibgA9PZ9TARFQxx2gweUC0uCZiHXbjS8vSszJHFnYj/JY6CCF/g8
         hfhx4OvxxXRlbVPG2libNTwO1xD1+AtR8eAh4sU6oa49tIHsLPgWyo4n5veb+xlHwNxE
         p7ajFqjpxfHLL4pug1UwkU+Tr+IdOb2cG2bBkVouPDaf6qfaWNSTTOnwY0LFBK3jmq1U
         y6vGclQfK++BW3WFxQnF+XdsUb94PDz1FThsmyGzAzVqx1wG3B4dbaNxhTf+8jJmucac
         Sf+TcAU8Lcji+3VIkkp0IYw0FsRxi/JfIF+T77zgxNz6I/4NUaplrXq55PO9pzf5v+B+
         MVqg==
X-Forwarded-Encrypted: i=1; AKwUvBzSXoHH4bi7QzIHyXflZAfcedAaN5tUCr7Gvb/Gi0vBAk1AjPTQSWDvbhjHGvGfrmlirNPJjdpTTEuzVOxN@lists.openembedded.org
X-Gm-Message-State: APuU4Z9OFK3C68EYOs3tCczuvWcYsRmArJMxI2oZY2hoKAwjNOZQx1pi
	Y4gM7DaVASSXgwLSL1ul50j2HjCLSY2tXZXEWITe2kkpptN08Jh9lnYTff1jmSnjoMU=
X-Gm-Gg: AYBFou0Et1e1ulSYu3SfRGad825cD5tUwWSNTkA2U7VuEktPo3vlcYQ0nP/uAFGugEs
	EQxD+3fZG7Ul3AiXNjSF5j9LDUY7XiYmt58zO6PkCaHCGOagaK1L8HPnmIHMTc8E+zcpPm/oI2H
	31nUstRZaxGqErKbEXB6z6P2vd3Eo+AoCz5y/cRF2xlYmRU/S/A3Gfvj21WjoVZRMMCfiLZootr
	n47VxpvdvvdSYgdP7PRNFC/1/ECoFE6qxLuMvhYg4U8bLaZTCxk+AraMJx7V6tutNBzJXQ0N8d/
	mjCwvQhKuvdAPyRI8ZRrMaWIkD5ppd1lSShVccZFyJNZ6f1qH7WhUP8CIIeEAmEYELkVvDYmORA
	027L4eJ6G1fMnKecTFTlEvXLHG/w/kzdInJANH76J+WJEsYYHB86ajA23IJXPa1B8Yc3v4V7WDy
	XJMGswqwfRIszA9aQF4qY83evXQPeh3IcS6uycXpqJZiKKQiKUeoqxvG3fUGboJVZDtA4AT4FoI
	XgYb1V+D5+l01uJeUdfU9S/PinUz2zDx9fFqfQ5MWWu4mIx7TickQX1ooBGW9j/Vi5eyEPapapi
	/HY5hSvXxYedXdVqNj1uSBf1FnK4vOZ9uOwGEzIEZI0A7WUkAIn96CglaKg5KKrf48P+cX22yzD
	wdyUirwwdb5DKOqOSeu+XGVaIDIjTshayNuP4z5s=
X-Received: by 2002:a05:600c:1d08:b0:4a5:87a:50ba with SMTP id 5b1f17b1804b1-4b6dfe8e3femr37933025e9.33.1793967448853;
        Fri, 06 Nov 2026 04:17:28 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:1e90:9dda:c43a:4321? ([2001:8b0:aba:5f3c:1e90:9dda:c43a:4321])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d809ddbbsm3517390f8f.53.2026.11.06.04.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 04:17:27 -0800 (PST)
Message-ID: <87910dcc110b0e4cc397d9f57d9b37824c6859f2.camel@linuxfoundation.org>
Subject: Re: [OE-core] [RFC] spdx30: name, version and purl for dependency
 downloads
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: stondo@gmail.com, openembedded-core@lists.openembedded.org
Cc: stefano.tondo.ext@siemens.com, bitbake-devel@lists.openembedded.org, 
 Joshua Watt <JPEWhacker@gmail.com>, Stefan Herbrechtsmeier
 <stefan.herbrechtsmeier@weidmueller.com>,  Alexander Kanavin
 <alex.kanavin@gmail.com>, Peter Marko <peter.marko@siemens.com>, Adrian
 Freihofer	 <adrian.freihofer@siemens.com>, Patrick Wicki
 <patrick.wicki@siemens.com>
Date: Fri, 06 Nov 2026 12:17:27 +0000
In-Reply-To: <20261105122145.543282-1-stondo@gmail.com>
References: <20261105122145.543282-1-stondo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10build1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Fri, 06 Nov 2026 12:17:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20403

On Thu, 2026-11-05 at 13:21 +0100, Stefano Tondo via openembedded-core wrot=
e:
> Yocto already knows each language dependency at fetch time for the
> recipes that list them in SRC_URI (crate://, gomod://, gomodgit://, and
> npmsw:// through its shrinkwrap file). The SPDX output loses most of
> that: the downloads are recorded, but without a name, version or
> package URL that a scanner can use, and dependencies fetched
> implicitly (git submodules, shrinkwrap dependencies) are not recorded
> at all.
>=20
> Measured on current master (oe-core 3a3eef7afb, bitbake 0f33b68cb,
> meta-openembedded 33f74f5dc5), source downloads in the build SPDX of
> each recipe, today and with the patches:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 today=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 with =
the patches
> =C2=A0 python3-bcrypt=C2=A0 42 crates, none with=C2=A0=C2=A0=C2=A0 all 42=
 with name,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 version or purl=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 version and purl
> =C2=A0 crucible=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 36 Go modules, =
none=C2=A0=C2=A0=C2=A0=C2=A0 all 36 with name,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 with version or purl=C2=A0=C2=A0=C2=A0 versi=
on and purl
> =C2=A0 p11-kit=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gitsm, sub=
module=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 submodule recorded with
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pkcs11-json missing=C2=A0=C2=A0=C2=A0=C2=A0 =
its own revision
> =C2=A0 webserver-oob=C2=A0=C2=A0 2 downloads, the 70=C2=A0=C2=A0=C2=A0=C2=
=A0 72 downloads, 71 with
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 shrinkwrap packages=C2=A0=C2=A0=C2=A0=C2=A0 =
a purl
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 missing
>=20
> webserver-oob is from TI's meta-tisdk, built on qemux86-64 without its
> am335x and meta-ti runtime dependencies and without one git.ti.com
> source that failed to clone, since neither oe-core nor
> meta-openembedded has an npmsw recipe. crucible also fetches 67
> go.mod-only entries (;mod=3D1), which are not compiled in and stay
> without an identity.
>=20
> Today a crate shows up as name "cipher-0.4.4.crate" with download
> location https://static.crates.io/crates/cipher/0.4.4/download, and a
> Go module as gomod://github.com/felixge/httpsnoop, with the version
> only in the file name "github.com.felixge.httpsnoop@v1.0.4.zip".
> Consumers end up parsing URLs and file names per ecosystem to recover
> what the fetcher already knew.
>=20
> I am aware of two earlier threads and would like to build on them, not
> reopen them:
>=20
> - Joshua's "lib: spdx30_tasks: Use Fetch.expanded_urldata()" (March
> =C2=A0 2025), which stalled on an intermittent edk2-firmware gitsm failur=
e
> =C2=A0 on the autobuilder. I think I found the cause: the patch passes ea=
ch
> =C2=A0 expanded URL to oe.patch.patch_path(), which calls
> =C2=A0 Fetch.localpath(url). For a URL that is not in SRC_URI, that creat=
es
> =C2=A0 a new FetchData with the recipe datastore, where the
> =C2=A0 SRCREV_<submodule> that the gitsm fetcher sets in its own datastor=
e
> =C2=A0 copy does not exist. A recipe with only named SRCREVs, like
> =C2=A0 edk2-firmware, then fails with "Please set a valid SRCREV". It
> =C2=A0 reproduces every time with meta-selftest's git-submodule-test give=
n
> =C2=A0 a named SRCREV. My guess for the intermittency is that gitsm only
> =C2=A0 lists the submodules when the clone is in DL_DIR.

We should revisit that and fix it as I think it exposes general bugs.

That said, I am thinking we should change the fetcher so all the
submodule urls are included in SRC_URI in future and expanded_urldata()
goes away. We need to update the other backends to match. I have no
knowledge of npm so that one will be hard for me.

Once we do that, your problem becomes easier too I think. It also means
I can then fix various mirror issues I'd like to change.

> - Stefan's "Concept for tightly coupled package manager" RFC (December
> =C2=A0 2024). My reading of that thread is that explicit SRC_URI lists
> =C2=A0 generated in layers (go-mod-update-modules,
> =C2=A0 cargo-update-recipe-crates) are the preferred model and that
> =C2=A0 fetchers should stay thin. This proposal assumes that model and do=
es
> =C2=A0 not add any dependency resolution to bitbake.

Yes, although just to be clear, I think bitbake needs to verify that
the dependencies are all listed.

> The patches have two parts.
>=20
> 1. Record implicit downloads
>=20
> =C2=A0=C2=A0 add_download_files() also records what implicit_urldata() re=
turns
> =C2=A0=C2=A0 for each SRC_URI entry, but keeps the patch check on the SRC=
_URI
> =C2=A0=C2=A0 entries, so implicit downloads are never set up again with t=
he
> =C2=A0=C2=A0 recipe datastore. The npmsw fetcher gets an implicit_urldata=
(),
> =C2=A0=C2=A0 since it already builds the list of URLs internally (ud.prox=
y). The
> =C2=A0=C2=A0 gitsm fetcher warns when the repository is not in DL_DIR, in=
stead
> =C2=A0=C2=A0 of silently returning no submodules.
>=20
> 2. Let the fetcher state the identity of what it downloads
>=20
> =C2=A0=C2=A0 FetchData gets a package_identity attribute, None by default=
 and
> =C2=A0=C2=A0 set in urldata_init() by the fetchers that know it:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 crate=C2=A0=C2=A0=C2=A0=C2=A0 ("cargo", "cipher"=
, "0.4.4", {})
> =C2=A0=C2=A0=C2=A0=C2=A0 gomod=C2=A0=C2=A0=C2=A0=C2=A0 ("golang", "github=
.com/felixge/httpsnoop", "v1.0.4", {})
> =C2=A0=C2=A0=C2=A0=C2=A0 gomodgit=C2=A0 same as gomod
> =C2=A0=C2=A0=C2=A0=C2=A0 npm=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ("npm", =
"@scope/name", "1.2.3", {})
> =C2=A0=C2=A0=C2=A0=C2=A0 npmsw=C2=A0=C2=A0=C2=A0=C2=A0 the same for each =
registry dependency
>=20
> =C2=A0=C2=A0 The last element holds purl qualifiers, so a crate or npm pa=
ckage
> =C2=A0=C2=A0 from another registry gets a repository_url. go.mod-only ent=
ries
> =C2=A0=C2=A0 get None. create-spdx-3.0 sets the name, software_packageVer=
sion and
> =C2=A0=C2=A0 software_packageUrl from it and builds the purl in oe-core, =
so
> =C2=A0=C2=A0 bitbake does not need to know the purl specification.
>=20
> =C2=A0=C2=A0 I first had a FetchMethod method in mind, but npmsw fetches =
its
> =C2=A0=C2=A0 dependencies through plain https URLs, so it has to attach t=
he
> =C2=A0=C2=A0 identity to each of them, and an attribute is enough for tha=
t. No
> =C2=A0=C2=A0 URL syntax changes, unlike the dn=3D/dv=3D parameters in Ste=
fan's
> =C2=A0=C2=A0 series.
>=20
> Both parts are small, about 35 lines in bitbake and 40 in oe-core plus
> tests. I tested them on master with new bitbake fetcher unit tests and
> new oe-selftest cases (submodules, including the named SRCREV case,
> and crate identity), which fail without the patches, and with the
> existing fetcher tests and the SPDX selftests closest to the change.
> Two bugs I found in the existing Git handling while doing this (gitsm
> skipped, changes not reaching the task signature) are fixed in a
> separate series, which the oe-core part builds on:
> https://lore.kernel.org/openembedded-core/20261104112257.866914-1-stondo@=
gmail.com/
>=20
> Questions:
>=20
> a) Is the fetcher the right place for the identity, or would you
> =C2=A0=C2=A0 prefer oe-core to derive it from each fetcher's FetchData? T=
he
> =C2=A0=C2=A0 latter avoids touching bitbake, but for npmsw it means readi=
ng the
> =C2=A0=C2=A0 internals of its proxy fetcher.

I think that the fetcher is the right place to do this as I would be
very much against poking fetcher internals from OE-Core.

We need to declare and document the stage at which this is expected to
work (i.e. before/after fetch, before/after unpack).

> b) Should bitbake keep returning the parts and leave the purl to
> =C2=A0=C2=A0 oe-core, as above, or return a purl directly?

It should probably return structured data including the purl from some
new API.

> c) For ecosystems without a fetcher (.NET/NuGet, Maven), would a
> =C2=A0=C2=A0 fetcher plus an update class following go-mod-update-modules=
 be
> =C2=A0=C2=A0 welcome, or is that better kept in a layer?

If the fetcher can conform to our APIs and roughly follow how
rust/crates are working today, I think those would be fine,
particularly if we have good tests too.

> d) Dependency scope. Identity alone does not give a correct SBOM: a
> =C2=A0=C2=A0 lock file lists what may be needed on any platform. python3-=
bcrypt
> =C2=A0=C2=A0 fetches wasi, wasip2 and wit-bindgen (WebAssembly only) and =
r-efi
> =C2=A0=C2=A0 (UEFI), and with the patches they show up with a clean purl =
as if
> =C2=A0=C2=A0 they were part of the product. As a follow-up I tried runnin=
g
> =C2=A0=C2=A0 cargo metadata --filter-platform ${RUST_HOST_SYS} in cargo.b=
bclass:
> =C2=A0=C2=A0 of the 42 crates, 25 are runtime, 12 only run at build time =
(build
> =C2=A0=C2=A0 scripts, proc-macros) and 5 are not used on the target. I re=
corded
> =C2=A0=C2=A0 them as LifecycleScopedRelationship dependsOn with scope run=
time or
> =C2=A0=C2=A0 build, and an annotation on the unused ones. Go (go list -de=
ps) and
> =C2=A0=C2=A0 npm (dev, optional, os and cpu in the shrinkwrap) could work=
 the
> =C2=A0=C2=A0 same way. Does that split sound right: declared scope from t=
he
> =C2=A0=C2=A0 fetcher where the lock file has it, observed scope from the
> =C2=A0=C2=A0 language classes? And is there a preferred SPDX representati=
on for
> =C2=A0=C2=A0 "fetched but not built"?

It sounds possibly right but I'd defer to Joshua on that one.

Cheers,

Richard
