Return-Path: <masahiroy@kernel.org>
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com
	[210.131.2.90])
	by mail.openembedded.org (Postfix) with ESMTP id BF0097FC40
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  8 Jan 2020 04:27:50 +0000 (UTC)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com
	[209.85.217.51]) (authenticated)
	by conssluserg-05.nifty.com with ESMTP id 0084RTgP025172
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 8 Jan 2020 13:27:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 0084RTgP025172
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
	s=dec2015msa; t=1578457649;
	bh=9X5d6ZmKgSqMWhuHFTXBQi4Hcsxz1MDKkNNt7Zr2JnI=;
	h=From:Date:Subject:To:Cc:From;
	b=eF3llC9WySGCsFKvwtQmbH7tv/Cnmz8gBLWkscw37brxwufElnVtiiUyo3QB2nuRL
	RkV5tKspZCbmvghly7GcCQaf7gzZcf+oBCepaTGAzLU4Th+1cSMZW9wYYMWROY5fic
	GX5ZOdUU6EiImsZjqawJryPcTV5PFNayySN7r2CsKDCcrtcIeEixyCJEA6Y+lXdhEa
	5jADsRmtj7I1hji1rTLTkyOLYR7jyaOd04TPxwCRWMwG5sZcKwPFxg7n4ar+47aXrp
	glGZtv4hVIzGYZNgbu27ycO3EUuSaDSx6lM7VLI7eaP8g97rwcjFFjujzZK5wvQadz
	YZZNsYvCXsOUQ==
X-Nifty-SrcIP: [209.85.217.51]
Received: by mail-vs1-f51.google.com with SMTP id b4so1007773vsa.12
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 07 Jan 2020 20:27:29 -0800 (PST)
X-Gm-Message-State: APjAAAWAJsaQe/uRLomsLlG99Cc/MXwJhQbZs5/s749bfRGubr0c5Xm5
	Oacw2eLKVwOlyDrQDEvtQGG1lTj7gnwvIwJrRHA=
X-Google-Smtp-Source: APXvYqyR9tPJISaKkU9fHrVG0lHvrUdgKUgrk6CdGPHuCIQGeTbjjnYGJGoF1HVg+dE6vwKQ1GOS3FpDeCPED7gMoWQ=
X-Received: by 2002:a05:6102:190:: with SMTP id
	r16mr1556558vsq.215.1578457648525; 
	Tue, 07 Jan 2020 20:27:28 -0800 (PST)
MIME-Version: 1.0
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 8 Jan 2020 13:26:52 +0900
X-Gmail-Original-Message-ID: <CAK7LNARkXaLFq8eJpNkbbkXDnRrVdXjXfYtHuqRA1OdO7AfU4g@mail.gmail.com>
Message-ID: <CAK7LNARkXaLFq8eJpNkbbkXDnRrVdXjXfYtHuqRA1OdO7AfU4g@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: Why does recrdeptask delete a task from the dependency graph?
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 08 Jan 2020 04:27:51 -0000
Content-Type: text/plain; charset="UTF-8"

Hi.

Forgive another of my recrdeptask questions.


I notice "recrdeptask" deletes a task in some cases.
I am not sure whether it is an intended behavior.


The test code is as follows:

-----------------(classes/base.bbclass  begin)----------
addtask do_build
do_build[nostamp] = "1"
do_build[deptask] = "do_build"
-----------------(classes/base.bbclass  end)------------

-----------------(recipes/foo.bb  begin)----------------
PN = 'foo'

python do_build() {
    bb.plain("foo.do_build");
}

DEPENDS = "bar"

do_build[recrdeptask] = "do_build"
-----------------(recipes/foo.bb  end)----------------


-----------------(recipes/bar.bb  begin)----------------
PN = 'bar'

python do_build() {
    bb.plain("bar.do_build")
}

DEPENDS = "baz"
-----------------(recipes/bar.bb  end)----------------


-----------------(recipes/baz.bb  begin)----------------
PN = 'baz'

python do_build() {
    bb.plain("baz.do_build")
}
-----------------(recipes/baz.bb  end)----------------




When I run "bitbake foo", I see
the expected result:

baz.do_build
bar.do_build
foo.do_build



If I add
  do_build[recrdeptask] = "do_build"
to recipes/bar.bb

"bitbake foo" shows

baz.do_build
foo.do_build


So, bar:do_build is dropped from the dependency.

What is the intent of this behavior?


--
Best Regards
Masahiro Yamada

