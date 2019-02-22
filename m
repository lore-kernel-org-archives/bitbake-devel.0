Return-Path: <akuster808@gmail.com>
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
	[209.85.215.195])
	by mail.openembedded.org (Postfix) with ESMTP id 0F4A07CBA2;
	Fri, 22 Feb 2019 16:39:06 +0000 (UTC)
Received: by mail-pg1-f195.google.com with SMTP id h8so858071pgp.6;
	Fri, 22 Feb 2019 08:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=NgtaIQ98PdIpiaaTCZ/KKyjb5YjmRU5XtEzzaY8xc6I=;
	b=LOITlh4YJTA5hKweGNKt31y3FPP2JedTM5w7DvVehsK9Q2/RnlwKtQK48RMYrk7a23
	XAQAejppVQrxaoMTBEFGqZknkM1HExJbARPaojIUsF2HckW3T7vlJ2N+EIReH5Fh6M3a
	0B2vLTSHeuSF9SoOjxu0KuNLB7P0j+djyX3h4sOfhw5dqCiZniLjue5bVnu3OidTjxMY
	SaF+oaPSL9aecgXw31+IIAvHC8hzecr4jZn3yH/4zgj/UpNw2QN6rpxUP5oG860NK9uA
	2RqEHQDyi3elZDfyRSnJX6IoXT01EutSQRUwZI052biVhSqaXEDDd4iulqtlYHCT2Plz
	Rv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=NgtaIQ98PdIpiaaTCZ/KKyjb5YjmRU5XtEzzaY8xc6I=;
	b=c15P+V07iUl4UJ6X/paaHFWC1Pl2KR7oKrgSODdNdb0eBLAFvkD+sa5+gbAgkDEXEK
	/NBSTXwwqUdTySXTwd7srHbbjBUa32/zNnmu9wMcZNEo7e3zxF6bXKocnr0QYsTn500I
	dUSQp66yor94yx65JGEhnttq+CWKE4pSOZRSV8YInQBdDWkCbLA7OMFHbuHPuuVr8bCG
	gSYz+c8nWzKfsVYxe3Bc2AIMzHbZeXnfrqiiB052PzxNTHaFbRo6SRURdYvamxIijWTN
	tV+Zw7q4AyunfRMwi1uhCk1lop5e69hgBVN3jea/rYG+yLyqzwsWsxfkyAgY7GjMDEFH
	YeIQ==
X-Gm-Message-State: AHQUAuZRfcnvW38x31kJOAKeS5ezhiWnkFcuxDsCBuKU5ZylEgIcpe4u
	SxjyK2ESDhepOXHkd9nXDZw=
X-Google-Smtp-Source: AHgI3IaZE9Ccgg1s8qdyPSopnOWxsTAJKnjHchtu2TKyHFSRJTcPia9UgQ+TL9XAnR9JHuu0RdrrqQ==
X-Received: by 2002:a63:5a42:: with SMTP id k2mr838073pgm.333.1550853545797;
	Fri, 22 Feb 2019 08:39:05 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:c33:70ef:357b:adf:5cc4])
	by smtp.gmail.com with ESMTPSA id c3sm4033730pfg.53.2019.02.22.08.39.04
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 22 Feb 2019 08:39:05 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: akuster808@gmail.com, openembedded-core@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org
Date: Fri, 22 Feb 2019 08:37:58 -0800
Message-Id: <cover.1550853097.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Subject: [PATCH 00/64] Sumo-next pull request
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
X-List-Received-Date: Fri, 22 Feb 2019 16:39:07 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Please consider this for Sumo.

Passed A-full

The following changes since commit 58e82c451071d0e257da6088cf643e636282084c:

  brief-yoctoprojectqs, dev-manual: Updated poky clone examples. (2019-01-16 15:35:54 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib stable/sumo-next
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=stable/sumo-next

Alexander Kanavin (2):
  oeqa: replace Alex Kanavin's @intel email address with a personal one
  oeqa/runtime/cases/python: use python 3 rather than python 2

Aníbal Limón (1):
  meta/classes/testimage.bbclass: Only validate IMAGE_FSTYPES when is
    QEMU

Armin Kuster (4):
  tzdata: update to 2018g
  tzcode-native: update to 2018g
  tzdata/tzcode-native: update to 2018i
  perl: add testdepends for ssh

Chen Qi (2):
  package.bbclass: fix python unclosed file ResourceWarning
  oeqa/runtime/cases/rpm.py: change to use base-passwd-doc

Douglas Royds (1):
  patch: reproducibility: Fix host umask leakage

Emmanuel Roullit (1):
  testimage.bbclass: fix qemu_use_kvm handling

Erik Botö (1):
  testimage: Add possibility to pass parmeters to qemu

Federico Sauter (1):
  kernel: don't assign the build user/host

Jeremy Puhlman (1):
  Only add uninative and checksum if inherited uninative class

Jose Perez Carranza (1):
  runtime/dnf: Add new dnf test cases

Kai Kang (1):
  testimage.bbclass: remove boot parameter systemd.log_target

Paul Eggleton (2):
  oe-selftest: devtool: avoid parallel races by using temporary copy of
    core
  bitbake: utils: add optional callback to edit_bblayers_conf()

Peter Kjellerstedt (3):
  bitbake: bitbake-diffsigs: Merge with bitbake-dumpsig
  bitbake: bitbake-diffsigs: Support recursive deps with signature files
  oe-selftest: devtool: Support meta being a symbolic link

Richard Purdie (25):
  busybox: Put klogd/syslogd alternative links in syslog package
  bitbake: server/process: Make lockfile handling clearer
  bitbake: server/process: Show the last 60 log lines, not the last 10
  bitbake: server/process: Show last 60 lines of the log if the server
    didn't start
  testimage/testsdk/selftest: Avoid platform.distro_identifier
    deprecation warnings
  package: Rework PACKAGELOCK based upon sstate for do_packagedata
  bitbake: server/process: Increase server startup time delay
  bitbake: cooker: Add some timing debug messages to the server startup
  bitbake: server/process: Ensure socket has a timeout set
  bitbake: process.py: Set socket timeout to 10 seconds
  bitbake: process: Handle EWOULDBLOCK in socket connect
  bitbake: process: Rewrite multiple connection handling
  testimage: Simplfy DEFAULT_TEST_SUITES logic
  testimage: Further cleanup DEFAULT_TEST_SUITES
  testimage: Enable autorunning of the package manager testsuites
  oeqa/runtime/cases: Improve test dependency information
  oeqa/runtime/cases: Improve dependencies of kernel/gcc/build tests
  oeqa/utils/buildproject: Only clean files if we've done something
  oeqa/utils/httpserver: Rework to avoid hangs and improve logging
  multilib_script: Add support for multilib scripts
  libtool: Fix problem with libtoolize in multilib installations
  libtool: Fix patch status tag
  libtool-cross: Handle ccache sstate 'infection' issues
  archiver/package_rpm: Fix the worst src.rpm generation race
  package_rpm/archiver: Apply bandaid to src.rpm creation

Robert Yang (7):
  bitbake: server/process: print a message when no logfile
  oeqa/utils/qemurunner: Print output when failed to login
  oeqa/utils/qemurunner: set timeout to 60s for run_serial
  oeqa: Fix for QEMU_USE_KVM
  oeqa: make it work for multiple users
  runqemu-gen-tapdevs: Allow run --help without sudo
  oeqa/selftest/runqemu: Enable kvm when QEMU_USE_KVM is set

Ross Burton (7):
  bitbake: layerindex: don't use shell=True when cloning
  bitbake: fetch: don't use shell=True when listing ar files
  runqemu: clean up subprocess usage
  oeqa/runtime/python: clean up Python test
  oeqa: rationalise Perl tests
  cpio: fix crash when appending to archives
  image_types: use cpio-native to build cpio images

Yeoh Ee Peng (4):
  scripts/oe-git-archive: fix non-existent key referencing error
  testimage: Add support for slirp
  oeqa/qemu & runtime: qemu do not need ip input from external
  oeqa/runtime/dnf: Make sure test_dnf_install does not skipped

 bitbake/bin/bitbake-diffsigs                       | 143 ++++++++++++---------
 bitbake/bin/bitbake-dumpsig                        |  95 +-------------
 bitbake/lib/bb/cooker.py                           |  19 +++
 bitbake/lib/bb/fetch2/__init__.py                  |   2 +-
 bitbake/lib/bb/server/process.py                   |  96 +++++++++-----
 bitbake/lib/bb/utils.py                            |  15 ++-
 bitbake/lib/bblayers/layerindex.py                 |   2 +-
 .../lib/oeqa/runtime/cases/dnf_runtime.py          |   2 +-
 meta/classes/archiver.bbclass                      |   6 +
 meta/classes/image_types.bbclass                   |   1 +
 meta/classes/kernel.bbclass                        |   4 +-
 meta/classes/multilib_script.bbclass               |  32 +++++
 meta/classes/package.bbclass                       |  26 ++--
 meta/classes/package_rpm.bbclass                   |   6 +-
 meta/classes/patch.bbclass                         |   1 +
 meta/classes/populate_sdk_ext.bbclass              |   5 +-
 meta/classes/testimage.bbclass                     |  78 +++++------
 meta/classes/testsdk.bbclass                       |   2 +-
 meta/lib/oe/types.py                               |  24 ++++
 meta/lib/oeqa/core/target/qemu.py                  |   5 +-
 meta/lib/oeqa/files/test.pl                        |   2 -
 meta/lib/oeqa/runtime/cases/apt.py                 |   2 +-
 meta/lib/oeqa/runtime/cases/buildcpio.py           |   9 +-
 meta/lib/oeqa/runtime/cases/buildgalculator.py     |   9 +-
 meta/lib/oeqa/runtime/cases/buildlzip.py           |  12 +-
 meta/lib/oeqa/runtime/cases/date.py                |   2 +
 meta/lib/oeqa/runtime/cases/df.py                  |   2 +
 meta/lib/oeqa/runtime/cases/dnf.py                 |  48 ++++++-
 meta/lib/oeqa/runtime/cases/gcc.py                 |  19 ++-
 meta/lib/oeqa/runtime/cases/kernelmodule.py        |   8 +-
 meta/lib/oeqa/runtime/cases/opkg.py                |   6 +-
 meta/lib/oeqa/runtime/cases/perl.py                |  30 +----
 meta/lib/oeqa/runtime/cases/ptest.py               |   2 +
 meta/lib/oeqa/runtime/cases/python.py              |  38 +-----
 meta/lib/oeqa/runtime/cases/rpm.py                 |  55 ++++----
 meta/lib/oeqa/runtime/cases/scp.py                 |   2 +
 meta/lib/oeqa/runtime/cases/ssh.py                 |   2 +
 meta/lib/oeqa/runtime/cases/stap.py                |   6 +-
 meta/lib/oeqa/runtime/cases/xorg.py                |   2 +
 meta/lib/oeqa/runtime/context.py                   |   7 +-
 meta/lib/oeqa/sdk/cases/perl.py                    |  25 +---
 meta/lib/oeqa/selftest/cases/devtool.py            |  65 ++++++++++
 meta/lib/oeqa/selftest/cases/distrodata.py         |   4 +-
 meta/lib/oeqa/selftest/cases/runqemu.py            |   5 +
 meta/lib/oeqa/selftest/cases/runtime_test.py       |   4 +-
 meta/lib/oeqa/selftest/cases/signing.py            |   2 +-
 meta/lib/oeqa/selftest/context.py                  |   3 +-
 meta/lib/oeqa/targetcontrol.py                     |  12 +-
 meta/lib/oeqa/utils/buildproject.py                |   5 +
 meta/lib/oeqa/utils/dump.py                        |   2 +-
 meta/lib/oeqa/utils/httpserver.py                  |  37 ++++--
 meta/lib/oeqa/utils/qemurunner.py                  |   3 +-
 meta/lib/oeqa/utils/qemutinyrunner.py              |   2 +-
 meta/recipes-core/busybox/busybox.inc              |   5 +-
 .../libtool/libtool-cross_2.4.6.bb                 |   8 ++
 .../libtool/libtool/multilib.patch                 |  23 ++++
 meta/recipes-devtools/libtool/libtool_2.4.6.bb     |   6 +
 .../cpio-2.12/0001-Fix-segfault-with-append.patch  |  87 +++++++++++++
 meta/recipes-extended/cpio/cpio_2.12.bb            |   1 +
 ...code-native_2018f.bb => tzcode-native_2018i.bb} |   8 +-
 .../tzdata/{tzdata_2018f.bb => tzdata_2018i.bb}    |   4 +-
 scripts/oe-git-archive                             |  19 ++-
 scripts/runqemu                                    |  63 +++++----
 scripts/runqemu-gen-tapdevs                        |  27 ++--
 64 files changed, 764 insertions(+), 483 deletions(-)
 mode change 100755 => 120000 bitbake/bin/bitbake-dumpsig
 create mode 100644 meta/classes/multilib_script.bbclass
 delete mode 100644 meta/lib/oeqa/files/test.pl
 create mode 100644 meta/recipes-devtools/libtool/libtool/multilib.patch
 create mode 100644 meta/recipes-extended/cpio/cpio-2.12/0001-Fix-segfault-with-append.patch
 rename meta/recipes-extended/tzcode/{tzcode-native_2018f.bb => tzcode-native_2018i.bb} (70%)
 rename meta/recipes-extended/tzdata/{tzdata_2018f.bb => tzdata_2018i.bb} (98%)

-- 
2.7.4


