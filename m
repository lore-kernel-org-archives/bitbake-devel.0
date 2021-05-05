Received: from kernel.crashing.org (kernel.crashing.org [76.164.61.194])
 by mx.groups.io with SMTP id smtpd.web11.1667.1620242582528328891
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 May 2021 12:23:02 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=permerror, err=syntax error for token:  (domain: kernel.crashing.org, ip: 76.164.61.194, mailfrom: mark.hatle@kernel.crashing.org)
Received: from Marks-MacBook-Pro-16.local ([76.164.61.198])
	(authenticated bits=0)
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 145JMtjo001546
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
	Wed, 5 May 2021 14:23:01 -0500
To: Patches and discussions about the oe-core layer
 <openembedded-core@lists.openembedded.org>,
        bitbake-devel <bitbake-devel@lists.openembedded.org>
From: "Mark Hatle" <mark.hatle@kernel.crashing.org>
Subject: Multiconfig - sstate-cache re-use and error
Message-ID: <269aefdd-0d6e-a73a-4d18-83ac609a55a3@kernel.crashing.org>
Date: Wed, 5 May 2021 14:22:55 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

I'm cross posting this cause I suspect it's a bitbake bug, but it requires
sstate-cache / setscene stuff which is from the oe-core side of things.  I
really don't know what is causing the problem, but I can at least reproduce it,
even if it ends up taking a while.

The configuration.  I'm building a system that has 4 multiconfigs (plus the
regular configuration), with the output being an SDK (main config), and 4
different rootfs from the multiconfig.  (See below for actual setup details for
the reproducer.)

What is happening.  The system starts building and appears to correctly defer
the building of the duplicate components.  Eventually it will start building the
item that is not deferred, and soon after it appears to change what is deferred
and will attempt to call setscene tasks, but the sstate-cache has not yet been
written to by the first task.  This is occurring on a completely new build, no
existing sstate-cache.

The console-log can show the order in which things are happening for a small
subset, so might be helpful.  In this chunk socat ended up showing this behavior:

NOTE: Deferring mc:qemuarm64-one:socat.bb:do_deploy_source_date_epoch after
mc:qemuarm64-four:socat.bb:do_deploy_source_date_epoch
[repeat for do_package]
[repeat for do_package_qa]
[repeat for do_package_write_rpm]
[repeat for do_packagedata]
[repeat for do_populate_lic]
[repeat for do_populate_sysroot]
*** repeat the sequence above for mc:qemuarm64-three which defers for four ***
*** repeat the sequence above for mc:qemuarm64-two which defers for four ***
NOTE: Running task 1362 of 15106 (mc:qemuarm64-four:socat_1.7.4.1.bb:do_fetch)
NOTE: recipe socat-1.7.4.1-r0: task do_fetch: Started
NOTE: recipe socat-1.7.4.1-r0: task do_fetch: Succeeded
NOTE: Running task 1397 of 15106 (mc:qemuarm64-four:socat_1.7.4.1.bb:do_unpack)
NOTE: recipe socat-1.7.4.1-r0: task do_unpack: Started
NOTE: recipe socat-1.7.4.1-r0: task do_unpack: Succeeded
NOTE: Running task 2617 of 15106 (mc:qemuarm64-four:socat_1.7.4.1.bb:do_patch)
NOTE: recipe socat-1.7.4.1-r0: task do_patch: Started
NOTE: recipe socat-1.7.4.1-r0: task do_patch: Succeeded
NOTE: Running task 2711 of 15106
(mc:qemuarm64-four:socat_1.7.4.1.bb:do_deploy_source_date_epoch)
NOTE: recipe socat-1.7.4.1-r0: task do_deploy_source_date_epoch: Started
NOTE: recipe socat-1.7.4.1-r0: task do_deploy_source_date_epoch: Succeeded
(starts deferring three again after one)
NOTE: Deferring mc:qemuarm64-three:socat_1.7.4.1.bb:do_deploy_source_date_epoch
after mc:qemuarm64-one:socat_1.7.4.1.bb:do_deploy_source_date_epoch
[repeat for do_package]
[repeat for do_package_qa]
[repeat for do_package_write_rpm]
[repeat for do_packagedata]
[repeat for do_populate_lic]
[repeat for do_populate_sysroot]
*** repeat the defer sequence above for mc:qemuarm64-two for one ***
NOTE: Running setscene task 1930 of 5424
(mc:qemuarm64-one:socat_1.7.4.1.bb:do_populate_sysroot_setscene)
NOTE: recipe socat-1.7.4.1-r0: task do_populate_sysroot_setscene: Started
ERROR: mc:qemuarm64-one:socat-1.7.4.1-r0 do_populate_sysroot_setscene: No
suitable staging package found
ERROR: Logfile of failure stored in:
...socat/1.7.4.1-r0/temp/log.do_populate_sysroot_setscene.154008
NOTE: recipe socat-1.7.4.1-r0: task do_populate_sysroot_setscene: Failed
WARNING: Setscene task
(mc:qemuarm64-one:socat_1.7.4.1.bb:do_populate_sysroot_setscene) failed with
exit code '1' - real task will be run instead
NOTE: Running task 3183 of 15106
(mc:qemuarm64-four:/socat_1.7.4.1.bb:do_populate_lic)
... now we have components of 'one' and 'four' building ...  eventually two and
three unlock as well and may build at the same time...

(Note, this build happened to be socat first, but other builds I've run have
different things that end up going first -- and it's not always the same items.)

Reproducer:

latest version of poky

$ . ./oe-init-build-env build-mc
$ mkdir conf/multiconfig

add the following files to multiconfig directory:

conf/multiconfig/qemuarm64-one.conf:
MACHINE = "qemuarm64"
SOC_VARIANT = "one"
TMPDIR = "${TOPDIR}/tmp-${MACHINE}-${SOC_VARIANT}-${TCLIBC}"

conf/multiconfig/qemuarm64-two.conf:
MACHINE = "qemuarm64"
SOC_VARIANT = "two"
TMPDIR = "${TOPDIR}/tmp-${MACHINE}-${SOC_VARIANT}-${TCLIBC}"

conf/multiconfig/qemuarm64-three.conf:
MACHINE = "qemuarm64"
SOC_VARIANT = "three"
TMPDIR = "${TOPDIR}/tmp-${MACHINE}-${SOC_VARIANT}-${TCLIBC}"

conf/multiconfig/qemuarm64-four.conf:
MACHINE = "qemuarm64"
SOC_VARIANT = "four"
TMPDIR = "${TOPDIR}/tmp-${MACHINE}-${SOC_VARIANT}-${TCLIBC}"

edit the conf/local.conf and add:

BBMULTICONFIG += "qemuarm64-one"
BBMULTICONFIG += "qemuarm64-two"
BBMULTICONFIG += "qemuarm64-three"
BBMULTICONFIG += "qemuarm64-four"

Start the build:
$ bitbake buildtools-tarball mc:qemuarm64-one:core-image-minimal
mc:qemuarm64-two:core-image-minimal mc:qemuarm64-three:core-image-minimal
mc:qemuarm64-four:core-image-minimal
