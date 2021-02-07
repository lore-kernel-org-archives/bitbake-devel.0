Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web12.21109.1612710120188392091
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 07 Feb 2021 07:02:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=COfiE0SO;
 spf=pass (domain: gmail.com, ip: 209.85.128.47, mailfrom: schnitzeltony@gmail.com)
Received: by mail-wm1-f47.google.com with SMTP id y134so2447167wmd.3
        for <bitbake-devel@lists.openembedded.org>; Sun, 07 Feb 2021 07:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fetbHraXmCrorOWvOEmyr/1XNAc+IHQAuQNhrBEdQUE=;
        b=COfiE0SOViDygQUwB+op9W6D6mP4ntPh39dS8rB4NZ2ju+4tbBOyYahtpwm7tPSYn2
         hu7R3I7NUyHA268XPdXBh9QDFeA8rgrV0reFoK/SartGFT2sdWVuwWhTsBQsxgt44LlI
         bIWBs7t5ckSewIkKDZptmYLdxea5bucfpMsPo68P2gerbgkcF2b3JxnLpV6i5dvRO9iU
         OtT9zXcvYeoSQllf76qzef4wnPnMNmO+ZzO7MkkNCtRkZ7yts55wI53zUrR8b7shhUfn
         8uo5dFhVa7Uf8OkWjyrPlaDr0ng2cs2G95tQIdkxkYPwa+3EOW56YQIvgCcdGzPO/pko
         s59g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fetbHraXmCrorOWvOEmyr/1XNAc+IHQAuQNhrBEdQUE=;
        b=eNBkRGZfKufmFmTV9JkUMZdCCgV4mxjLT3aKFS89pTIC2R3wwEPpgJvcUbAJk4JwSN
         /RBTzlAirfycr8ezxw2e79sbcaYDcXZotCGS7jwvzA/AUe9R3/m+lRQm8zMl08wTe6Pn
         rPakun+5ONJoUnAvcdyIErF3ksm0SFqmL5DFCQbj5rpiSDXwpWpLxpeGGpNFo3Vnsxww
         nzQMwf4V/yhI6EDCtARuwpkX4qnnK3pFh0+uIvUW5NgmCJ71ECNCzJV66dWvsR8WJs3F
         ndtcRy01s7kPWSzmPUimesQmVLPLgUcY/bZbi18WZ3LCG12XclJ+LNmY2+rS3PwkuKWr
         kagA==
X-Gm-Message-State: AOAM533SQ2oraUS2TawBlcEseySCdSIbKufbeV7KcEQETrIsFYEQpCrb
	6P0NOsCL0aY8rqRa2+E05HMe5viW3rM=
X-Google-Smtp-Source: ABdhPJw1Uf3yp7uFps83YBs/DOWTdPbkW9tKmy9ZD1ZUljA4DRSgcgNO7XTDW9t7fCIehB4wndoMvA==
X-Received: by 2002:a7b:ca57:: with SMTP id m23mr11288409wml.116.1612710118624;
        Sun, 07 Feb 2021 07:01:58 -0800 (PST)
Return-Path: <schnitzeltony@gmail.com>
Received: from superandy.speedport.ip (p200300f07f44b13017fa725760fbfa73.dip0.t-ipconnect.de. [2003:f0:7f44:b130:17fa:7257:60fb:fa73])
        by smtp.gmail.com with ESMTPSA id 9sm24229114wra.80.2021.02.07.07.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 07:01:57 -0800 (PST)
From: =?UTF-8?B?QW5kcmVhcyBNw7xsbGVy?= <schnitzeltony@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: alex.kanavin@gmail.com,
	randy.macleod@windriver.com,
	ross.burton@arm.com
Subject: [RFC-cargo-fetcher 0/3] Suggest a first step
Date: Sun,  7 Feb 2021 16:01:44 +0100
Message-Id: <20210207150147.31011-1-schnitzeltony@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is a first version of a cargo fetcher. It mimics cargo fetch means
it creates cargo cache in ${DL_DIR}/cargo. As mentioned in comments the
proxy-thingy was stolen from npmsw for shrinkwrap files.

First approach was to parse Cargo.toml for projects that don't ship a
Cargo.lock (crates for rustlibs should do this) but that was skipped:
An unknown magic inside cargo detects which libs are avaiable: Blindly
followin -> download explodedc [1]

As proof of concept I did (no meta-rust in layers to avoid surprises):

* add a simple cargo-fetch.bbclass to oe-core [2]
* adapt a pure rust recipe 'spotifyd' to new fetcher [3-4]
* moved console to source of spotifyd and did
  > export CARGO_HOME="<DL_DIR>/cargo"
  > export CARGO_TARGET_DIR="<B>"
  > cargo build --frozen
  --> project was build without issues

Please review carefully because I am aware that:

* my python could be better
* the 'one cache for all in download area thingy' might cause issues I do not
  see yet

Am also aware that this is not more than a first step. Once this makes it in,
further TODOs are:

* Merge latest meta-rust -> oe-core (latest: There were some riscv adjustments
  recently - and I am not sure if these are in the poky-contrib of Alex/Ross)
* Add documentation / tests / devtool-support / ??

[1] https://github.com/schnitzeltony/mimic-cargo-fetcher/blob/master/test.py
[2] https://github.com/schnitzeltony/openembedded-core/blob/cargo-fetcher/meta/classes/cargo-fetch.bbclass
[3] https://github.com/schnitzeltony/meta-musicians/blob/cargo-fetcher/recipes-streaming/spotify/spotifyd.bb
[4] https://github.com/schnitzeltony/meta-musicians/blob/cargo-fetcher/recipes-streaming/spotify/spotifyd/Cargo.lock

Andreas Müller (3):
  Add a fetcher for cargo crate index
  Add parser for toml configuration files
  Add a fetcher for cargo crates

 lib/bb/fetch2/__init__.py   |    4 +
 lib/bb/fetch2/crateindex.py |  155 +++++
 lib/bb/fetch2/cratelock.py  |  268 +++++++++
 lib/toml/LICENSE            |   27 +
 lib/toml/README             |    8 +
 lib/toml/__init__.py        |   25 +
 lib/toml/__init__.pyi       |   15 +
 lib/toml/decoder.py         | 1057 +++++++++++++++++++++++++++++++++++
 lib/toml/decoder.pyi        |   52 ++
 lib/toml/encoder.py         |  304 ++++++++++
 lib/toml/encoder.pyi        |   34 ++
 lib/toml/ordered.py         |   15 +
 lib/toml/ordered.pyi        |    7 +
 lib/toml/source-origin      |    1 +
 lib/toml/tz.py              |   24 +
 lib/toml/tz.pyi             |    9 +
 16 files changed, 2005 insertions(+)
 create mode 100644 lib/bb/fetch2/crateindex.py
 create mode 100644 lib/bb/fetch2/cratelock.py
 create mode 100644 lib/toml/LICENSE
 create mode 100644 lib/toml/README
 create mode 100644 lib/toml/__init__.py
 create mode 100644 lib/toml/__init__.pyi
 create mode 100644 lib/toml/decoder.py
 create mode 100644 lib/toml/decoder.pyi
 create mode 100644 lib/toml/encoder.py
 create mode 100644 lib/toml/encoder.pyi
 create mode 100644 lib/toml/ordered.py
 create mode 100644 lib/toml/ordered.pyi
 create mode 100644 lib/toml/source-origin
 create mode 100644 lib/toml/tz.py
 create mode 100644 lib/toml/tz.pyi

-- 
2.26.2

