Return-Path: <rpjday@crashcourse.ca>
Received: from astoria.ccjclearline.com (astoria.ccjclearline.com
	[64.235.106.9])
	by mail.openembedded.org (Postfix) with ESMTP id 7C8C47043A
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Jul 2014 14:51:40 +0000 (UTC)
Received: from [69.196.158.250] (port=45612 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1X4tDg-0002mV-6Q for bitbake-devel@lists.openembedded.org;
	Wed, 09 Jul 2014 10:51:40 -0400
Date: Wed, 9 Jul 2014 10:51:31 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Message-ID: <alpine.LFD.2.11.1407091031530.9521@localhost>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
X-AntiAbuse: This header was added to track abuse,
	please include it with any abuse report
X-AntiAbuse: Primary Hostname - astoria.ccjclearline.com
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Subject: more user manual questions about bitbake tasks
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
X-List-Received-Date: Wed, 09 Jul 2014 14:51:47 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII


  it's humbling to realize all the niggling little details i don't
understand completely. oh, well ... some questions about bitbake
tasks, most of which i think i know the answers to but let's play it
safe.

  first, is it true that the *only* way to define a bitbake task is
with the "addtask" directive? given that, one can at least consult
OE's base.bbclass to see the low-level tasks that will be defined for
all work, which i just noticed is a surprisingly short list:

$ grep "^addtask" meta/classes/base.bbclass
addtask fetch
addtask unpack after do_fetch
addtask configure after do_patch
addtask compile after do_configure
addtask install after do_compile
addtask build after do_populate_sysroot
addtask cleansstate after do_clean
addtask cleanall after do_cleansstate
$

  a couple observations about the above. i notice the general format
of the "addtask" directive:

  addtask X after do_Y

where the "do_" prefix is used only on the latter task name. (you'll
see why i mention this shortly.)

  also, i notice that

    addtask build after do_populate_sysroot

defines a task as being run after another task that is undefined in
base.bbclass; that's ok, i can see it being defined in
staging.bbclass:

  addtask populate_sysroot after do_install

so i assume the general rule is that you can define tasks that
"depend" on other tasks that you only have to *eventually* define,
correct?

  one more question. i'm puzzled by this snippet from staging.bbclass:

  python do_populate_sysroot_setscene () {
      sstate_setscene(d)
  }
  addtask do_populate_sysroot_setscene

why is it

  addtask do_populate_sysroot_setscene

rather than:

  addtask populate_sysroot_setscene

i thought the general form of addtask was:

  addtask X ... etc etc ...

the bitbake user manual definitely doesn't explain the syntax of

  addtask do_X ...

but there seems to be some of that scattered around:

$ grep -r "^addtask do_" *
meta/classes/kernel.bbclass:addtask do_strip before do_sizecheck after do_kernel_link_vmlinux
meta/classes/staging.bbclass:addtask do_populate_sysroot_setscene
meta/classes/package_rpm.bbclass:addtask do_package_write_rpm_setscene
meta/classes/license.bbclass:addtask do_populate_lic_setscene
meta/classes/archiver.bbclass:addtask do_ar_original after do_unpack
... snip ...

  are both forms valid?  more task questions coming shortly on another
topic.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================








