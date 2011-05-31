Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1QRXyM-0008Oi-P6 for bitbake-devel@lists.openembedded.org;
	Wed, 01 Jun 2011 01:03:39 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p4VN0TqH022743
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 1 Jun 2011 00:00:29 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 21711-09 for <bitbake-devel@lists.openembedded.org>;
	Wed,  1 Jun 2011 00:00:25 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p4VN0JxK022727
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 1 Jun 2011 00:00:20 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 01 Jun 2011 00:00:04 +0100
Message-ID: <1306882804.27470.402.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: RFC: Override expansion - changing the behaviour
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 31 May 2011 23:03:39 -0000
X-Groupsio-MsgNum: 13
Content-Type: multipart/mixed; boundary="=-KbJUkrncs1EzTzwvAUL1"

--=-KbJUkrncs1EzTzwvAUL1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Currently if you do:

OVERRIDES = "z"
DEPENDS_prepend = "a "
DEPENDS = "b"
DEPENDS_z = "c"

d.update_data()
d.getVar("DEPENDS") gives "a c"
d.update_data()
d.getVar("DEPENDS") gives "c"

I'm proposing we should change the bitbake behaviour such that at the
time bitbake expands the DEPENDS_z override, it removes "DEPENDS_z" from
the data store.

In the above example this would mean that it wouldn't matter how often
you call d.update_data(), you'd always get "a c" back.

This is a fairly major change in behaviour so the question is what is
the likely impact to existing systems. To check into that I've devised a
patch which parses the metadata and saves out the datastore as parsed.
If the data is already present it will list the differenced between it
and the existing data. I've then assumed the metadata in OE-Core is
representative and made some tests on it.

The baseline data (ignoring the __base_depends and TIME variables) was:

$ touch conf/local.conf 
$ bitbake core-image-sato -g 
[...]
$ touch conf/local.conf 
$ bitbake core-image-sato -g 
NOTE: Out of date cache found, rebuilding...
NOTE: Variable BB_BASEHASH_task-do_bootimg(content) changed from 8abe544bb45386aa3228c53d29965efc to 9918e6d60bba2bead7079c02ff07f460       
NOTE: Variable BB_BASEHASH_task-do_bootimg(content) changed from 7ec98c48f134c67b8ad93837dbb89025 to ac42a8ade2b7361ca6049f338323efee
NOTE: Variable BB_BASEHASH_task-do_populate_sdk(content) changed from 3f2c6e5f8ebb90bfe4e0b01d3f5b9bfe to 2a08f65f0dd7933d88e1e353ba0e263c
NOTE: Variable BB_BASEHASH_task-do_bootdirectdisk(content) changed from 906e35362d949ee08d53522cd3c91c86 to ed100e159e205d25848b1a139686d9c7
NOTE: Variable BB_BASEHASH_task-do_bootimg(content) changed from 105e1321d452e9d62616e21ca0382ba4 to 7296313feba540ddb155c9216deef95a
NOTE: Variable BB_BASEHASH_task-do_bootdirectdisk(content) changed from 8a376303f61fb09f7a23378f9a688edc to 0c5c44baf48b3cdf129d7b722f1b9509
NOTE: Variable BB_BASEHASH_task-do_bootimg(content) changed from 0cafcf23b8a6382d4d60febf0824042f to db0f70b813d513b80d8fb5a740d3e6f0
NOTE: Variable BB_BASEHASH_task-do_populate_sdk(content) changed from 06a328a672551fa5a6baf1666005c74d to 6a0a23e0234919b1b55bc633919ee737
NOTE: Variable BB_BASEHASH_task-do_generate_content(content) changed from 53c5fcc503372e0455c6436aaa3603a8 to 9b976b9dcea65ca1d7813f26ff74e641
NOTE: Variable BB_BASEHASH_task-do_populate_sdk(content) changed from 21f3d18c425404d4b9dda29dea79246f to c405f07f9fc4f2c7c8c7f7a623d3760b
NOTE: Variable BB_BASEHASH_task-do_populate_sdk(content) changed from ea9b9e2ec8d4b024bfd2ac2f887d60a0 to ac55c4e9c074a8941150fb112ef81ef5
NOTE: Variable BB_BASEHASH_task-do_bootdirectdisk(content) changed from ee3f87895e9e26b9543f9158c1405bcb to 82ac6687e9ee0393ecee345feaac3574
NOTE: Variable BB_BASEHASH_task-do_bootimg(content) changed from 4777ac9660c0230a72942facf8225d01 to bee704c11cf4d680a9a92a2bfa323533
Parsing of 783 .bb files complete (0 cached, 783 parsed). 1001 targets, 13 skipped, 0 masked, 0 errors.

(I didn't enable filename output on this but its clear its from tasks
with DATE/TIME dependencies so these changes aren't a surprise).

I then applied my change in behaviour to bitbake and reparsed.

For the comparison, I've excluded anything from this list where a
variable changed contents which had the name *virtclass-*. The reasoning
is that we don't have any place in the metadata where we directly
dereference the full named version of these variables. This makes the
list a little more readable:

$ touch conf/local.conf 
$ time bitbake core-image-sato -g 
NOTE: Out of date cache found, rebuilding...
NOTE: Variable ASNEEDED_pn-rpm(content) changed from  to None (/tmp/bbsave/rpm_5.4.0.bb)  
NOTE: Variable ASNEEDED_pn-distcc(content) changed from  to None (/tmp/bbsave/distcc_2.18.3.bb)
NOTE: Variable DESKTOPINSTALL_libc-glibc(content) changed from     install -d ${D}${datadir}/distcc/
    install -m 0644 ${WORKDIR}/distccmon-gnome.desktop ${D}${datadir}/distcc/
 to None (/tmp/bbsave/distcc_2.18.3.bb)
NOTE: Flag func in variable DESKTOPINSTALL_libc-glibc disappeared (/tmp/bbsave/distcc_2.18.3.bb)
NOTE: Flag func in variable do_install_virtclass-native disappeared (/tmp/bbsave/binutils_2.21.bbnative)         
NOTE: Flag func in variable do_install_virtclass-native disappeared (/tmp/bbsave/binutils-crosssdk_2.21.bbnative)
NOTE: Flag func in variable do_install_virtclass-native disappeared (/tmp/bbsave/binutils-cross-canadian_2.21.bbnative)
NOTE: Flag func in variable do_install_virtclass-native disappeared (/tmp/bbsave/binutils-cross_2.21.bbnative)
NOTE: Variable BB_BASEHASH_task-do_buildall(content) changed from 01be347d9d39d35b93982691de7578b5 to e8a39cd6c321c9114ea9ae6853e75cd7 (/tmp/bbsave/intltool_0.40.6.bbnative)  
NOTE: Flag export in variable PERL_virtclass-native disappeared (/tmp/bbsave/intltool_0.40.6.bbnative)
NOTE: Variable BB_BASEHASH_task-do_package_write(content) changed from 01be347d9d39d35b93982691de7578b5 to e8a39cd6c321c9114ea9ae6853e75cd7 (/tmp/bbsave/intltool_0.40.6.bbnative)
NOTE: Variable BB_BASEHASH_task-do_package_write_rpm_setscene(content) changed from a4f69a004a31cd3cf529c978342c3423 to 4f995188b8e3ba19ee35f9b455c8cdbc (/tmp/bbsave/intltool_0.40.6.bbnative)
NOTE: Variable BB_BASEHASH_task-do_populate_lic_setscene(content) changed from a4f69a004a31cd3cf529c978342c3423 to 4f995188b8e3ba19ee35f9b455c8cdbc (/tmp/bbsave/intltool_0.40.6.bbnative)
NOTE: Variable BB_BASEHASH_task-do_devshell(content) changed from e03946d56f12d74acd57c1629642621a to 7a1261fcd11991b07c9942f890ae99db (/tmp/bbsave/intltool_0.40.6.bbnative)
NOTE: Variable BB_BASEHASH_task-do_populate_sysroot(content) changed from d605ca766df88f8c9a2e2b46166fe379 to c8fa2aa352640dbe2c28744a87cafbcd (/tmp/bbsave/intltool_0.40.6.bbnative)
NOTE: Variable BB_BASEHASH_task-do_configure(content) changed from aa58885014f2884d2c75da6c8e4db7af to 8c82c55e641d0de452e8e4b2e33bd985 (/tmp/bbsave/intltool_0.40.6.bbnative)
NOTE: Variable BB_BASEHASH_task-do_checkuriall(content) changed from 01be347d9d39d35b93982691de7578b5 to e8a39cd6c321c9114ea9ae6853e75cd7 (/tmp/bbsave/intltool_0.40.6.bbnative)
NOTE: Variable BB_BASEHASH_task-do_compile(content) changed from 7f78bd1073cbba067c5b075f03533c4a to 0848e8774d954485fd9bdbb297a2f3ce (/tmp/bbsave/intltool_0.40.6.bbnative)
NOTE: Variable BB_BASEHASH_task-do_populate_sysroot_setscene(content) changed from a4f69a004a31cd3cf529c978342c3423 to 4f995188b8e3ba19ee35f9b455c8cdbc (/tmp/bbsave/intltool_0.40.6.bbnative)
NOTE: Variable BB_BASEHASH_task-do_fetchall(content) changed from 01be347d9d39d35b93982691de7578b5 to e8a39cd6c321c9114ea9ae6853e75cd7 (/tmp/bbsave/intltool_0.40.6.bbnative)
NOTE: Variable BB_BASEHASH_task-do_install(content) changed from 73199b10f19780e409eaad2589e01e06 to c0652a84492ab99c89004ef042ad5f5b (/tmp/bbsave/intltool_0.40.6.bbnative)
NOTE: Variable BB_BASEHASH_task-do_build(content) changed from 01be347d9d39d35b93982691de7578b5 to e8a39cd6c321c9114ea9ae6853e75cd7 (/tmp/bbsave/intltool_0.40.6.bbnative)
NOTE: Variable BB_BASEHASH_task-do_package_setscene(content) changed from a4f69a004a31cd3cf529c978342c3423 to 4f995188b8e3ba19ee35f9b455c8cdbc (/tmp/bbsave/intltool_0.40.6.bbnative)
NOTE: Variable RDEPENDS_task-core-lsb-graphic-add_qemux86(content) changed from     libqtopengl4  to None (/tmp/bbsave/task-core-lsb.bb)
NOTE: Variable BB_BASEHASH_task-do_bootimg(content) changed from 8abe544bb45386aa3228c53d29965efc to c1a65834157b5ed43c9c8220d608fea2 (/tmp/bbsave/core-image-lsb-live.bb)      
NOTE: Variable BB_BASEHASH_task-do_bootimg(content) changed from 7ec98c48f134c67b8ad93837dbb89025 to 20c10600593d2871d100c9cdacd2dce5 (/tmp/bbsave/core-image-lsb-sdk-live.bb)
NOTE: Flag func in variable do_install_virtclass-native disappeared (/tmp/bbsave/ghostscript_9.02.bbnative)                             
NOTE: Flag func in variable do_configure_virtclass-native disappeared (/tmp/bbsave/ghostscript_9.02.bbnative)
NOTE: Flag func in variable do_compile_virtclass-native disappeared (/tmp/bbsave/ghostscript_9.02.bbnative)
NOTE: Flag python in variable do_patch_virtclass-native disappeared (/tmp/bbsave/ghostscript_9.02.bbnative)
NOTE: Flag func in variable do_patch_virtclass-native disappeared (/tmp/bbsave/ghostscript_9.02.bbnative)
NOTE: Variable LSOF_OS_libc-glibc(content) changed from linux to None (/tmp/bbsave/lsof_4.84.bb)                 
NOTE: Variable ASNEEDED_pn-icu(content) changed from  to None (/tmp/bbsave/icu_3.6.bb)                            
NOTE: Flag func in variable do_install_virtclass-native disappeared (/tmp/bbsave/shared-mime-info_0.90.bbnative)  
NOTE: Flag func in variable do_configure_virtclass-native disappeared (/tmp/bbsave/freetype_2.4.4.bbnative)       
NOTE: Variable EXCLUDE_FROM_WORLD_pn-clutter-box2d(content) changed from 1 to None (/tmp/bbsave/clutter-box2d_git.bb)
NOTE: Variable TARGET_CC_ARCH_arm_pn-mesa-xlib(content) changed from -march=i586 to None (/tmp/bbsave/mesa-xlib_7.10.2.bb)
NOTE: Variable RRECOMMENDS_gstreamer_qemux86(content) changed from  kernel-module-snd-ens1370 kernel-module-snd-rawmidi to None (/tmp/bbsave/gstreamer_0.10.32.bb) 
NOTE: Variable ASNEEDED_pn-pulseaudio(content) changed from  to None (/tmp/bbsave/pulseaudio_0.9.15.bb)
NOTE: Variable ASNEEDED_pn-pulseaudio(content) changed from  to None (/tmp/bbsave/pulseaudio_0.9.22.bb)
NOTE: Variable KMACHINE_qemux86(content) changed from yocto/standard/common-pc/base to None (/tmp/bbsave/linux-yocto_git.bb)
NOTE: Variable SRCREV_machine_qemux86(content) changed from b2afed7ecd54918b73db7f30062aaaf02fdaba54 to None (/tmp/bbsave/linux-yocto_git.bb)
NOTE: Variable QT_GLFLAGS_qemux86(content) changed from -opengl to None (/tmp/bbsave/qt4-x11-free_4.7.3.bb)
NOTE: Variable BB_BASEHASH_task-do_populate_sdk(content) changed from 3f2c6e5f8ebb90bfe4e0b01d3f5b9bfe to 79ae63b96596a285366bee5e1ff0376c (/tmp/bbsave/meta-toolchain-qte.bb)
NOTE: Variable EXCLUDE_FROM_WORLD_pn-eds-tools(content) changed from 1 to None (/tmp/bbsave/eds-tools_bzr.bb)
NOTE: Variable ASNEEDED_pn-puzzles(content) changed from  to None (/tmp/bbsave/puzzles_r9173.bb)
NOTE: Variable BB_BASEHASH_task-do_bootimg(content) changed from 105e1321d452e9d62616e21ca0382ba4 to d8b545984abbae73cc72f73d18246270 (/tmp/bbsave/core-image-sato-live.bb)
NOTE: Variable BB_BASEHASH_task-do_bootdirectdisk(content) changed from 8a376303f61fb09f7a23378f9a688edc to e535f7b5db8ab168ef0fd9b9147b27c3 (/tmp/bbsave/core-image-sato-sdk-directdisk.bb)
NOTE: Variable BB_BASEHASH_task-do_bootimg(content) changed from 0cafcf23b8a6382d4d60febf0824042f to df9504d5e2bcb882bdee203c8d09ff1a (/tmp/bbsave/core-image-sato-sdk-live.bb)
NOTE: Variable BB_BASEHASH_task-do_bootdirectdisk(content) changed from 906e35362d949ee08d53522cd3c91c86 to 1a2dfc525a0e1622de09fe09c13a6639 (/tmp/bbsave/core-image-sato-directdisk.bb)
NOTE: Variable OWL_poky(content) changed from --enable-owl to None (/tmp/bbsave/contacts_git.bb)
NOTE: Variable OWL_poky(content) changed from --enable-owl --disable-dnd to None (/tmp/bbsave/dates_git.bb)
NOTE: Variable OWL_poky(content) changed from --enable-owl to None (/tmp/bbsave/contacts_0.9.bb)
NOTE: Variable OWL_poky(content) changed from --with-owl to None (/tmp/bbsave/tasks_0.19.bb)
NOTE: Variable OWL_poky(content) changed from --enable-owl to None (/tmp/bbsave/tasks_git.bb)
NOTE: Variable OWL_poky(content) changed from --enable-owl --disable-dnd to None (/tmp/bbsave/dates_0.4.8.bb)
NOTE: Variable ASNEEDED_pn-pciutils(content) changed from  to None (/tmp/bbsave/pciutils_3.1.7.bb)
NOTE: Variable EXCLUDE_FROM_WORLD_pn-gobject-introspection(content) changed from 1 to None (/tmp/bbsave/gobject-introspection_git.bb)
NOTE: Variable SDK-EXTRAS_qemux86(content) changed from  valgrind lttng-ust-dev to None (/tmp/bbsave/task-core-standalone-gmae-sdk-target.bb)
NOTE: Variable SDK-EXTRAS_qemux86(content) changed from  valgrind lttng-ust-dev to None (/tmp/bbsave/task-core-sdk-gmae.bb)
NOTE: Variable RRECOMMENDS_gtk+_libc-glibc(content) changed from ${GTKGLIBC_RRECOMMENDS} to None (/tmp/bbsave/gtk+_2.12.7.bb)
NOTE: Variable RRECOMMENDS_gtk+_libc-glibc(content) changed from ${GTKGLIBC_RRECOMMENDS} to None (/tmp/bbsave/gtk+_2.22.1.bb)
NOTE: Variable RRECOMMENDS_gtk+_libc-glibc(content) changed from ${GTKGLIBC_RRECOMMENDS} to None (/tmp/bbsave/gtk+_2.16.6.bb)
NOTE: Variable ENABLE_BINARY_LOCALE_GENERATION_pn-glibc-nativesdk(content) changed from 0 to None (/tmp/bbsave/glibc_2.10.1.bbnativesdk)
NOTE: Flag func in variable do_install_virtclass-native disappeared (/tmp/bbsave/dbus_1.4.1.bbnative)
NOTE: Variable ENABLE_BINARY_LOCALE_GENERATION_pn-eglibc-nativesdk(content) changed from 0 to None (/tmp/bbsave/eglibc_2.12.bbnativesdk)
NOTE: Variable ENABLE_BINARY_LOCALE_GENERATION_pn-eglibc-nativesdk(content) changed from 0 to None (/tmp/bbsave/eglibc_2.13.bbnativesdk)
NOTE: Variable BB_BASEHASH_task-do_populate_sdk(content) changed from 06a328a672551fa5a6baf1666005c74d to 7b324767972020cf7fbbfcec7234709a (/tmp/bbsave/external-python-tarball.bb)
NOTE: Variable BB_BASEHASH_task-do_generate_content(content) changed from 53c5fcc503372e0455c6436aaa3603a8 to 7ebaac1a1815be948aeda09aa08da0f7 (/tmp/bbsave/meta-environment.bb)
NOTE: Variable BB_BASEHASH_task-do_populate_sdk(content) changed from 21f3d18c425404d4b9dda29dea79246f to 377c0d96af0bc090f654dfa321134130 (/tmp/bbsave/meta-toolchain.bb)
NOTE: Variable BB_BASEHASH_task-do_populate_sdk(content) changed from ea9b9e2ec8d4b024bfd2ac2f887d60a0 to 3efc642a10f2a012e7412b4750bdeabc (/tmp/bbsave/meta-toolchain-gmae.bb)
NOTE: Variable BB_BASEHASH_task-do_bootdirectdisk(content) changed from ee3f87895e9e26b9543f9158c1405bcb to e9354cb677fac53fe0924bbf7f0752f3 (/tmp/bbsave/core-image-minimal-directdisk.bb)
NOTE: Variable BB_BASEHASH_task-do_bootimg(content) changed from 4777ac9660c0230a72942facf8225d01 to 9bc113fdffb796c9749a50e86a52d6d4 (/tmp/bbsave/core-image-minimal-live.bb)
NOTE: Variable PACKAGE_ARCH_qemux86(content) changed from ${MACHINE_ARCH} to None (/tmp/bbsave/netbase_4.45.bb)
NOTE: Variable ASNEEDED_pn-console-tools(content) changed from  to None (/tmp/bbsave/console-tools_0.3.2.bb)
Parsing of 783 .bb files complete (0 cached, 783 parsed). 1001 targets, 13 skipped, 0 masked, 0 errors.

Of the things in this list, many are overrides which get expanded and
removed from the datastore that aren't virtclass-* ones (or are flag
changes rather than variable contents). This is expected and those can
be discounted from the list of changes.

The changes that would worry me are variables themselves without
overrides (there don't appear to be any) and the BASEHASH* changes. The
task hashes are designed to represent all the inputs to tasks. If this
change has no impact all the hashes would be expected to be the same.

Some BASEHASH changes are expected so discounting the DATE/TIME issues
we'd expect (as shown by the control) the rest are intltool-native
changes. There, an export PERL_virtclass-native variable is playing
havok.

The crazy thing is that its the "PERL_virtclass-native" variable that
was getting exported and is no longer. The code doesn't "export PERL" as
you'd expect before or after this change. I'm therefore concluding that
this change is harmless (or more correct) even if the BASEHASH does
change.

I've tested a build with this change applied and after I fixed a bug in
the PREFERRED_VERSION handling code and an issue with allarch.bbclass
unrelated to this code change the build was successful.

So the question is should we make this change?

It would:

* make things work more as expected
* possibly make the parser slightly faster
* make the data store slightly smaller
* allow simplification of native.bbclass and BBCLASSEXTEND usage

with the last point being the primary driver for fixing this as it would
avoid some horrible hacks.

I've attached two patches, my instrumentation and the override behaviour
change. These need some cleanup tweaks but illustrate the change I'm
proposing. The if len > 0 test was due to some weirdness I noticed where
we're caching empty overrides (variables ending in "_" ?).

Cheers,

Richard



--=-KbJUkrncs1EzTzwvAUL1
Content-Disposition: attachment; filename*0=0001-bitbake-Add-ability-to-save-out-parsed-recipes-and-t.pat; filename*1=ch
Content-Type: text/x-patch; name="0001-bitbake-Add-ability-to-save-out-parsed-recipes-and-t.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

From 8ae0b3d9fbe314e33923ad2dfe9ea1ded95f66ff Mon Sep 17 00:00:00 2001
From: Richard  Purdie <richard.purdie@linuxfoundation.org>
Date: Tue, 31 May 2011 23:06:12 +0100
Subject: [PATCH 1/2] bitbake: Add ability to save out parsed recipes and then compare the data

Signed-off-by: Richard  Purdie <richard.purdie@linuxfoundation.org>
---
 bitbake/lib/bb/cache.py |   49 ++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index d083c51..34210fc 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -127,13 +127,56 @@ class RecipeInfo(namedtuple('RecipeInfo', recipe_fields)):
         return cls(**kwargs)
 
     @classmethod
-    def from_metadata(cls, filename, metadata):
+    def from_metadata(cls, filename, metadata, virtualfn):
         if cls.getvar('__SKIPPED', metadata):
             return cls.make_optional(skipped=True,
                                      file_depends=metadata.getVar('__depends', False),
                                      timestamp=bb.parse.cached_mtime(filename),
                                      variants=cls.listvar('__VARIANTS', metadata) + [''])
 
+        tname = "/tmp/bbsave/" + str(os.path.basename(virtualfn)) + bb.cache.Cache.virtualfn2realfn(virtualfn)[1]
+
+        bb.mkdirhier("/tmp/bbsave/")
+        newdict = {}
+        for k in metadata.keys():
+            newdict[k] = metadata.getVarFlags(k)
+            if newdict[k] == None:
+                newdict[k] = {}
+            newdict[k]['content'] = metadata.getVar(k, False)
+
+        if os.path.exists(tname):
+            # Compare against existing data
+            with open(tname, "rb") as tfile:
+                pickled = pickle.Unpickler(tfile)
+                olddict = pickled.load()
+                for k in olddict:
+                    # Ignore non-interesting bits
+                    if k == "__base_depends" or k == "TIME":
+                        continue
+                    if k not in newdict:
+                        bb.note("Variable %s disappeared (%s)" % (k, tname))
+                        continue
+                    for f in olddict[k]:
+                        if f not in newdict[k]:
+                            bb.note("Flag %s in variable %s disappeared (%s)" % (f, k, tname))
+                            continue
+                        if newdict[k][f] != olddict[k][f]:
+                            if k.find("virtclass-") == -1:
+                                bb.note("Variable %s(%s) changed from %s to %s (%s)" % (k, f, olddict[k][f], newdict[k][f], tname))
+                    for f in newdict[k]:
+                        if f not in olddict[k]:
+                            bb.note("Flag %s in variable %s added %s" % (f, k, tname))
+                            continue
+                for k in newdict:
+                    if k not in olddict:
+                        bb.note("Variable %s was added" % k)
+
+        else:
+            # Otherwise save data out
+            with open(tname, "wb") as tfile:
+                pickler = pickle.Pickler(tfile, pickle.HIGHEST_PROTOCOL)
+                pickler.dump(newdict)
+
         tasks = metadata.getVar('__BBTASKS', False)
 
         pn = cls.getvar('PN', metadata)
@@ -314,7 +357,7 @@ class Cache(object):
             depends |= (data.getVar("__depends", False) or set())
             if depends and not variant:
                 data.setVar("__depends", depends)
-            info = RecipeInfo.from_metadata(filename, data)
+            info = RecipeInfo.from_metadata(filename, data, virtualfn)
             infos.append((virtualfn, info))
         return infos
 
@@ -500,7 +543,7 @@ class Cache(object):
         """
 
         realfn = self.virtualfn2realfn(file_name)[0]
-        info = RecipeInfo.from_metadata(realfn, data)
+        info = RecipeInfo.from_metadata(realfn, data, file_name)
         self.add_info(file_name, info, cacheData, parsed)
 
     @staticmethod
-- 
1.7.4.1


--=-KbJUkrncs1EzTzwvAUL1
Content-Disposition: attachment; filename*0=0002-bitbake-data_smart-Change-overrides-behaviour-to-rem.pat; filename*1=ch
Content-Type: text/x-patch; name="0002-bitbake-data_smart-Change-overrides-behaviour-to-rem.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

From 21c0b340716fb5fa82b06ec4c5b8ffa4ffc97b48 Mon Sep 17 00:00:00 2001
From: Richard  Purdie <richard.purdie@linuxfoundation.org>
Date: Tue, 31 May 2011 23:52:50 +0100
Subject: [PATCH 2/2] bitbake/data_smart: Change overrides behaviour to remove expanded variables from the datastore

Currently if you do:

OVERRIDES = "z"
DEPENDS_prepend = "a "
DEPENDS = "b"
DEPENDS_z = "c"

d.update_data()
d.getVar("DEPENDS")

gives "a c"

d.update_data()
d.getVar("DEPENDS")

then gives "c"

This patch changes the behaviour such that at the time bitbake expands the DEPENDS_z
override, it removes "DEPENDS_z" from the data store. In the above example this would
mean that it wouldn't matter how often you call d.update_data(), you'd always get
"a c" back.

See the bitbake-devel mailing list for further discussion and analysis of the
potential impact of this change.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bitbake/lib/bb/data_smart.py |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index 67866d5..a956104 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -172,11 +172,15 @@ class DataSmart(MutableMapping):
             if o not in self._seen_overrides:
                 continue
 
-            vars = self._seen_overrides[o]
+            vars = self._seen_overrides[o].copy()
             for var in vars:
                 name = var[:-l]
                 try:
                     self.setVar(name, self.getVar(var, False))
+                    #if name.find("PREF") != -1:
+                    #    bb.note("Removing %s as set %s" % (var, name))
+                    self.delVar(var)
+                    self._seen_overrides[o].remove(var)
                 except Exception:
                     logger.info("Untracked delVar")
 
@@ -258,9 +262,10 @@ class DataSmart(MutableMapping):
         # more cookies for the cookie monster
         if '_' in var:
             override = var[var.rfind('_')+1:]
-            if override not in self._seen_overrides:
-                self._seen_overrides[override] = set()
-            self._seen_overrides[override].add( var )
+            if len(override) > 0:
+                if override not in self._seen_overrides:
+                    self._seen_overrides[override] = set()
+                self._seen_overrides[override].add( var )
 
         # setting var
         self.dict[var]["content"] = value
-- 
1.7.4.1


--=-KbJUkrncs1EzTzwvAUL1--
