Return-Path: <patrick.ohly@intel.com>
Received: from mail-io0-f172.google.com (mail-io0-f172.google.com
	[209.85.223.172])
	by mail.openembedded.org (Postfix) with ESMTP id ECC69780F6
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Jun 2017 13:56:31 +0000 (UTC)
Received: by mail-io0-f172.google.com with SMTP id b184so7195629ioe.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 07 Jun 2017 06:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=qW/3CNahDLJTdI5ntpiZxYaeY3rm56KU5CrMarU6Pe0=;
	b=R1Y+/WnNgOJ2J/QkJGb6LcMoY9YCA9WLqHGT5/U8Q4c24m3Laht5lW9kjpPgsNcKvP
	e4oB2Cehv9VtAMxqNrFibpIbzO8JO7HEAOl1Tm5e8hxc9/U2wI9rJXdIVm7qIg/umQ0x
	0WQqWMUjRhRGZuIKTB4b7sOFP5en9kkftpOYLHlG4wVlXfwkv4t6P/L79SU16ctnsmnZ
	eiH1hUU2y/OQCk1ZbAQyHrwDfLsYQPH4Ec1VEbw8vY4felHYMXTsrCK5uDMRce9um3EN
	FT20hZP/KTWMTXDiy6MsnpBCPn3Z3AppOj1cDIfNAGbawgQSMayjglXaLTSHaepbbNFc
	q6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=qW/3CNahDLJTdI5ntpiZxYaeY3rm56KU5CrMarU6Pe0=;
	b=QCF1QQ+0/CnhGXYERbBqm5cYQZqsuLy07SwF5J16200OTqXXJXRDRC2lCVEwcHtrtE
	zwbcqXMYehox3s7rRFksUYsWIlEzHOOcCOn//+cBzsVmxGvDpCxYYf0E81aygDFZJTXx
	1fC3wgbmH2WgR1oQE4xap701ZajudZJ86/p/zWqrivlwHpoNhLRjI3LgEwhpUHXllfNA
	pGh4h5t7GEP40GlJLgDhweB7NqLm3rT6BmaWmySePzJlt2Tnaf+el7CYHtI6BF43OSj7
	PzIttjkc/x7aqZP4eTXUX+ASOuPCCnV14oaGHNkOsLqx0vNSFditK0J0HQ/MaJIT8Ar1
	kndg==
X-Gm-Message-State: AODbwcCR1qi1hSGdi5vkq4sFWLEh/+m5TrjdDOaGkv7jWZ5hVGUZ5jpj
	Z1MoK5G2nxueh2PZ1P8=
X-Received: by 10.107.136.211 with SMTP id s80mr13364209ioi.18.1496843792388; 
	Wed, 07 Jun 2017 06:56:32 -0700 (PDT)
Received: from pohly-desktop.fritz.box (p5DE8FFF1.dip0.t-ipconnect.de.
	[93.232.255.241]) by smtp.gmail.com with ESMTPSA id
	e32sm1065133itd.18.2017.06.07.06.56.30
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 07 Jun 2017 06:56:31 -0700 (PDT)
From: Patrick Ohly <patrick.ohly@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  7 Jun 2017 15:56:23 +0200
Message-Id: <cover.36a6c17ae3fab020393e82b397fb5a16681be9d7.1496843701.git-series.patrick.ohly@intel.com>
X-Mailer: git-send-email 2.11.0
Subject: [PATCH 0/2] more flexible include and require statements
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
X-List-Received-Date: Wed, 07 Jun 2017 13:56:32 -0000

As discussed in the "[Openembedded-architecture] Yocto Compatible 2.0
+ signature changes" mail thread, some changes in a .bbappend cannot
be made conditional via overrides, like for example manipulating
varflags.

By allowing "require" and "include" without parameter, one can include
those changes depending on some condition with ${@ } which expands to
empty when the condition is not met.

However, this is still not particularly developer-friendly, in
particular when the change is needed under different conditions (like
one of several DISTRO_FEATURES) or more than one include file is
involved.

When allowing also to include more than one file in a single
statement, some helper function could be written which takes a
declaration of the relationship between features and include files and
then a single line covers all cases.

The example in the second commit uses this helper function which
should go into OE-core because of the DISTRO_FEATURES default value:

def optional_includes(d, mapping, key_var="DISTRO_FEATURES"):
    """
    This can be used to generate a list of files to include depending on
    the distro features that are selected. key_var contains the features
    that are set, mapping_var a space-separated set of <feature(s)>:<file(s)>
    entries. Features and files are separated by comma. Each file on the
    right-hand side is included in the result once if any of the features one
    the left-hand side is set.

    Example:
       require ${@ oe.utils.optional_includes(d, "foo,bar:foo-or-bar.inc xyz:x.inc,y.inc,z.inc")}

    For DISTRO_FEATURES = "foo xyz" that will include four .inc files in the
    order in which they are listed.
    """
    key = set((d.getVar(key_var) or "").split())
    mapping = mapping.split()
    includes = []
    for entry in mapping:
        parts = entry.split(":", 1)
        if len(parts) != 2:
            bb.fatal("%s must contain entries of the form <feature(s)>:<file(s)>, not %s" % (mapping_var, entry))
        features, files = parts
        for feature in features.split(","):
            if feature in key:
                for file in files.split(","):
                    if file not in includes:
                        includes.append(file)
    return " ".join(includes)

Patrick Ohly (2):
  ConfHandler.py: allow inherit or include without parameter
  ConfHandler.py: allow inherit or include with multiple parameters

 lib/bb/parse/parse_py/ConfHandler.py | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

base-commit: cf2bf9a0b0d9380025f61c7e7a39e6e19b46a7a1
-- 
git-series 0.9.1

