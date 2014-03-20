Return-Path: <olof.johansson@axis.com>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
	by mail.openembedded.org (Postfix) with ESMTP id A78CD60CEB
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Mar 2014 15:03:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id 374A32E4EB;
	Thu, 20 Mar 2014 16:03:47 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id 9+CIvNgBmrNf; Thu, 20 Mar 2014 16:03:46 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bes.se.axis.com (Postfix) with ESMTP id 7748F2E377;
	Thu, 20 Mar 2014 16:03:46 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 34C1FE3D;
	Thu, 20 Mar 2014 16:03:46 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.se.axis.com (Postfix) with ESMTP id 26EA8B7D;
	Thu, 20 Mar 2014 16:03:46 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by seth.se.axis.com (Postfix) with ESMTP id 248153E048;
	Thu, 20 Mar 2014 16:03:46 +0100 (CET)
Received: from lnxolofjn.se.axis.com (10.92.17.1) by xmail2.se.axis.com
	(10.0.5.74) with Microsoft SMTP Server id 8.3.342.0; Thu, 20 Mar 2014
	16:03:45 +0100
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)	id A8EA59C29D; 
	Thu, 20 Mar 2014 16:03:45 +0100 (CET)
Date: Thu, 20 Mar 2014 16:03:45 +0100
From: Olof Johansson <olof.johansson@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	<bitbake-devel@lists.openembedded.org>
Message-ID: <20140320150345.GB951@axis.com>
References: <cover.1392908060.git.pkj@axis.com>
	<c7f06c48293a2d7edc3894fe5259a8704afd1e17.1392908060.git.pkj@axis.com>
	<1393068245.5181.8.camel@ted>
MIME-Version: 1.0
In-Reply-To: <1393068245.5181.8.camel@ted>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: Peter Kjellerstedt <pkj@axis.com>
Subject: Re: [PATCH 1/1] bitbake: Disable pseudo in runfetchcmd()
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
X-List-Received-Date: Thu, 20 Mar 2014 15:03:50 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On 14-02-22 12:24 +0100, Richard Purdie wrote:
> On Thu, 2014-02-20 at 15:55 +0100, Peter Kjellerstedt wrote:
> > If a fetcher, e.g., git, is run when pseudo is active it will think it
> > is running as root. If it in turn uses ssh (as git does), ssh too will
> > think it is running as root. This will cause it to try to read root's
> > ssh configuration from /root/.ssh which will fail. If ssh then needs to
> > ask for credentials it will hang indefinitely as there is nowhere for it
> > to ask the user for them (and even if there was it would not access the
> > correct private keys).
> > 
> > The solution to the above is to temporarily disable pseudo while
> > executing any fetcher commands. There should be no reason for them to be
> > executed under pseudo anyway so this should not be a problem.
> > 
> > Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> > ---
> >  bitbake/lib/bb/fetch2/__init__.py | 3 +++
> >  1 file changed, 3 insertions(+)

I work with Peter, and I'm seeing this issue as well. Sorry for
the delay in response.

> I'm more than a little concerned about why pseudo is active during
> do_patch. It shouldn't be. Are you doing anything different with pseudo
> in your build?

No, not as far as I know. This is the output I'm seeing
currently, where I temporarily replaced "git" with a small shell
script that runs whoami and exits with failure (normally, it
would just hang at this point) (somewhat trimmed for brevity):


....
DEBUG: Starting bitbake-worker
DEBUG: Using cache in '/oe/master/build/cache/bb_codeparser.dat'
ERROR: Failure expanding variable do_patch: ExpansionError: Failure expanding variable do_patch, expression was         cd /oe/master/build/tmp/work/p3367-poky-linux/linux-porky/3.10+axis12-r4.1.1/linux
        export KMETA=${KMETA}

        # if kernel tools are available in-tree, they are preferred
        # and are placed on the path before any external tools. Unless
        # the external tools flag is set, in that case we do nothing.
        if [ -f "/oe/master/build/tmp/work/p3367-poky-linux/linux-porky/3.10+axis12-r4.1.1/linux/scripts/util/configme" ]; then
                if [ -z "${EXTERNAL_KERNEL_TOOLS}" ]; then
                        PATH=/oe/master/build/tmp/work/p3367-poky-linux/linux-porky/3.10+axis12-r4.1.1/linux/scripts/util:/oe/master/scripts:/oe/master/build/tmp/sysroots/x86_64-linux/usr/bin/mipsel-nf-poky-linux:/oe/master/build/tmp/sysroots/p3367/usr/bin/crossscripts:/oe/master/build/tmp/sysroots/x86_64-linux/usr/sbin:/oe/master/build/tmp/sysroots/x86_64-linux/usr/bin:/oe/master/build/tmp/sysroots/x86_64-linux/sbin:/oe/master/build/tmp/sysroots/x86_64-linux/bin:/oe/master/scripts:/oe/master/bitbake/bin:/home/olofjn/bin:/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin:/var/cfengine/bin:/usr/local/mipsisa32r2el/r23/bin
                fi
        fi

        machine_branch="${@ get_machine_branch(d, "master" )}"

        # ...
        # trimmed down output
        # ...
 which triggered exception FetchError: Fetcher failure: Fetch command failed with exit code 1, output:
+ whoami
+ : whoami = root
+ id
+ : id = uid=0(root) gid=0(root) groups=0(root)
+ exit 1

ERROR: Task 100 (/oe/master/meta-porky/recipes-kernel/linux/linux-porky_3.10.bb, do_package_write_rpm) failed with exit code '1'


Note that bitbake complains about do_patch, but the executed task
is actually do_package_write_rpm. I'm not sure what this means.

Any ideas?

-- 
olofjn

