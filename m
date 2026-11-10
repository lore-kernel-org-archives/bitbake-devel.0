Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3899.1794347980299299465
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 Nov 2026 13:59:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=oFH+F+Xb;
 spf=pass (domain: gmail.com, ip: 209.85.221.46, mailfrom: stondo@gmail.com)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4922dbcee23so1486292f8f.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 10 Nov 2026 13:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794347978; x=1794952778; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tufce84eKqalwllI7ornj5dKnt3yOJo4iy2SbsWLX/8=;
        b=oFH+F+XbZcjEsu8W+JJb3gm8jD3VVAGq00LvcpRw4G0CXnJ8Qn0nZ0gxQ8BqPL6M82
         CQ7aVL/m8j+BVnIK7VoMqcjSFVi+iZ13jRX+taspbBZIp3HyFo8WZpTZuwvncB2KvAQE
         InbtPiypKsWZ3qDcQWxP4wrlQS9MpC3TGuNMZv/C7aM/67Ik8f5HmF0tq3DfF3WHQEXV
         RTvXKRilECSX/+6HKbI4obJP1ePrw59o6rlXkt/TPUK6njMoqe5jBK6lX98Vg5YzI7Rj
         BsvwQVAh8TiQ1UZJ0o5lIzjgneyYMhOVT0wMs42quBGUELvK3XIFRCvU9uIzmjHxYSTO
         hYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794347978; x=1794952778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tufce84eKqalwllI7ornj5dKnt3yOJo4iy2SbsWLX/8=;
        b=iOvXjmkL9Y6LMO6iZvEDIIgBfByJfjPKgSqxb34mqe6qYOPY2Mz65qtgYe8uO4PmuP
         rIOK3dEq9NjuRw3RKqk887N1RopAx0tx84GVTX+Jz+N+b31y1WqQHA+noCI1a5EOK64N
         l0pNG0gsQVMrwBVMHPymESJRK8o5/pK4apz+Jyz9spgY6zeZ6RzcpKJieek8H6XFEIbZ
         qR7qIb70yX2mvG9UTm5em3zV2fiXJZl0DNPQpwSKipG+zYGm6cfsGOulTDltbT8jwRLD
         b3RaCt8VhE3E5xR8eekFaOv1cpGaWoHLuCjj1TaER/6Va4ZuOMo2dtNcQS0+ziUfwoM9
         toqg==
X-Forwarded-Encrypted: i=1; AL+hErHObdVfgA9A6StSQVq1XCNhEaY1TK4A107LrxbUzJg4Gf/PQT2RGqrd2sDDwpLGE+E7oL13ZL8NJr+5VT2x@lists.openembedded.org
X-Gm-Message-State: APuU4Z8D5s8qLQy+uznwfHYiK0ceb8h7qcCwNNS5vbKV20LWwMRq/520
	dzb0HnpnX2T9DAmrF4dE1eNCio9UOaqQudoHfcQXZReyIKqLwDf+FxoF
X-Gm-Gg: AYBFou1VyDz4foOiEE2xO+qOkurdc/WzX2BkNFX979aC5I8xzOGDaymgEePabnG0drK
	2kpQaSsyPD9gHfStG1ZoDrgWFTnwLMXl2DLVUeBdamW3u2Xt3lMmXtd26MU8d2TpcRKHmYexTnL
	pTzPR9NTtCMgFa7LgubITy13twBa67FmD/oXgUMZkJrXLeeRcaY4F54heJtUVVKTPxx9rliFTRu
	R9349aFem8yfnsIvAfFIDS+jonq551P8XyG+Bg0unXbwLkukqNCD7EyZiUsbQyboRaz6SYV6KiI
	ni+my6cIsazdrFBfhBuGJgJVcYRcU5vsiCTO3Wf9T4dFO6F8dUCuzUgTIBpGEsULooM1XUX0EBb
	7j4D78a7RFb9+b7SvHq3HUcfwlguZyJ8n2gB4PeYYK1uIsUL68UfXS2kTV39EXia3oZepHW2I2l
	Y+Io71TvCOrSk4US+CXeNVLnehrXDiUFf1PkFkkjCdCD6kVByLKyLypehPjagyJSuHdhT39XlBn
	jJC+mgxxXehy2TL2XiYTliyPbpn0GdHgIpiQNPADMp9XSP6bzs3cC4F6cjKHwvms12ClaKpgI/V
	K7AXnuJZTAeNcSuQ9JnIiG5qTnLYMGo2W9fztPRAW6YZ/CirNCMtg93d2D+CHqo=
X-Received: by 2002:a05:6000:22c8:b0:48e:62a9:1a65 with SMTP id ffacd0b85a97d-499c8c654d1mr384844f8f.49.1794347978179;
        Tue, 10 Nov 2026 13:59:38 -0800 (PST)
Return-Path: <stondo@gmail.com>
Received: from fedora ([81.6.40.168])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983284cce7sm7413806f8f.8.2026.11.10.13.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 13:59:35 -0800 (PST)
From: Stefano Tondo <stondo@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: stefano.tondo.ext@siemens.com,
	Alexander Kanavin <alex.kanavin@gmail.com>,
	openembedded-core@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org,
	Joshua Watt <JPEWhacker@gmail.com>,
	Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
	Peter Marko <peter.marko@siemens.com>,
	Adrian Freihofer <adrian.freihofer@siemens.com>,
	Patrick Wicki <patrick.wicki@siemens.com>
Subject: Re: [RFC] spdx30: name, version and purl for dependency downloads
Date: Tue, 10 Nov 2026 22:59:35 +0100
Message-ID: <20261110215935.107339-1-stondo@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <87910dcc110b0e4cc397d9f57d9b37824c6859f2.camel@linuxfoundation.org>
References: <87910dcc110b0e4cc397d9f57d9b37824c6859f2.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Tue, 10 Nov 2026 21:59:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20415
Content-Type: text/plain; charset="utf-8"

Hi Richard, hi Alex,

Thank you both for the feedback. Your replies point in the same
direction, so I answer them together here.

On Fri, 6 Nov 2026 at 12:04, Alexander Kanavin wrote:
> - do not make fetchers any more complex than they already are.
> [...] Rather try to do as much as possible in oe-core through a
> clear API.

On Fri, 6 Nov 2026 at 12:17, Richard Purdie wrote:
> I think that the fetcher is the right place to do this as I would
> be very much against poking fetcher internals from OE-Core. We need
> to declare and document the stage at which this is expected to work
> (i.e. before/after fetch, before/after unpack).
> [...]
> It should probably return structured data including the purl from
> some new API.

I think these two points fit together. The fetchers already parse the
name and the version of each dependency for their own use. The new
API only returns that data as a documented structure, with the purl.
It does not change the fetch or the unpack. oe-core then writes
the SPDX from it and does not read any fetcher internals.

About the stage: crate, gomod and npmsw know the identity when they
create the FetchData. That is before fetch, and it needs no network
access. npmsw only reads its shrinkwrap file, which is a local file
in the layer. gitsm is the exception, because it can list the
submodules only from the clone. When the submodules are in SRC_URI,
that exception goes away. So I propose to document "before fetch".

> I am thinking we should change the fetcher so all the submodule urls
> are included in SRC_URI in future and expanded_urldata() goes away.
> We need to update the other backends to match. I have no knowledge
> of npm so that one will be hard for me.

Alex wrote:
> - gitsm and npmsw are historical mistakes, however 'convenient' they
> may be. [...] I would want to replace them with flat, explicit
> implementations.

I agree, and I would like to help with npm. My idea is to follow
cargo-update-recipe-crates and go-mod-update-modules: an update class
writes one SRC_URI entry with a checksum for each package in the
shrinkwrap file. Then bitbake checks that the list matches the
shrinkwrap file, as you said in your reply. Is
that what you have in mind? If yes, I can prepare patches.

This also makes my RFC smaller. Its first part records implicit
downloads. With flat SRC_URI lists, there are no implicit downloads
left to record.

> We should revisit that and fix it as I think it exposes general
> bugs.

I can investigate this too. I have a reproducer that fails every time:
meta-selftest's git-submodule-test with a named SRCREV. The bug I
found is in Fetch.localpath() for a URL that is not in SRC_URI. It
creates a new FetchData with the recipe datastore, which does not
have the SRCREV that gitsm set for the submodule. Is this the bug you
mean, or do you know of others in this area? I can start from any
cases you have.

> If the fetcher can conform to our APIs and roughly follow how
> rust/crates are working today, I think those would be fine,
> particularly if we have good tests too.

Thanks, that is clear. I will come back to new fetchers only after
we agree on the API.

Joshua, Richard deferred question d) to you. In short: a lock file
lists packages for all platforms, so the fetcher downloads some
dependencies that are never built for the target. I proposed to take
the declared scope from the lock file in the fetcher, and the
observed scope from the language classes (for example cargo metadata
--filter-platform). Does that split work for you? And how do you want
"fetched but not built" to look in SPDX 3.0?

For the next step: crate and gomod already list every dependency in
SRC_URI, so the identity API can work for them now. Do you want me to
send patches for these two, with tests, and add npm after the
flattening? Or do you prefer that I wait for Joshua's answer first?

Thanks,
Stefano
