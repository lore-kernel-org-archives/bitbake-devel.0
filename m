Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 5CBCC60CEB
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Mar 2014 15:14:48 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s2KFEU4l006137; Thu, 20 Mar 2014 15:14:30 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ZZr71enZzeO5; Thu, 20 Mar 2014 15:14:30 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s2KFEPoD006133
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 20 Mar 2014 15:14:26 GMT
Message-ID: <1395328459.3808.180.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Olof Johansson <olof.johansson@axis.com>
Date: Thu, 20 Mar 2014 15:14:19 +0000
In-Reply-To: <20140320150345.GB951@axis.com>
References: <cover.1392908060.git.pkj@axis.com>
	<c7f06c48293a2d7edc3894fe5259a8704afd1e17.1392908060.git.pkj@axis.com>
	<1393068245.5181.8.camel@ted> <20140320150345.GB951@axis.com>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Cc: Peter Kjellerstedt <pkj@axis.com>, bitbake-devel@lists.openembedded.org
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
X-List-Received-Date: Thu, 20 Mar 2014 15:14:51 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2014-03-20 at 16:03 +0100, Olof Johansson wrote:
>I work with Peter, and I'm seeing this issue as well. Sorry for
> the delay in response.
> 
> > I'm more than a little concerned about why pseudo is active during
> > do_patch. It shouldn't be. Are you doing anything different with pseudo
> > in your build?
> 
> No, not as far as I know. This is the output I'm seeing
> currently, where I temporarily replaced "git" with a small shell
> script that runs whoami and exits with failure (normally, it
> would just hang at this point) (somewhat trimmed for brevity):
> 
> 
> ....
> DEBUG: Starting bitbake-worker
> DEBUG: Using cache in '/oe/master/build/cache/bb_codeparser.dat'
> ERROR: Failure expanding variable do_patch: ExpansionError: Failure expanding variable do_patch, expression was         cd /oe/master/build/tmp/work/p3367-poky-linux/linux-porky/3.10+axis12-r4.1.1/linux
>         export KMETA=${KMETA}
> 
>         # if kernel tools are available in-tree, they are preferred
>         # and are placed on the path before any external tools. Unless
>         # the external tools flag is set, in that case we do nothing.
>         if [ -f "/oe/master/build/tmp/work/p3367-poky-linux/linux-porky/3.10+axis12-r4.1.1/linux/scripts/util/configme" ]; then
>                 if [ -z "${EXTERNAL_KERNEL_TOOLS}" ]; then
>                         PATH=/oe/master/build/tmp/work/p3367-poky-linux/linux-porky/3.10+axis12-r4.1.1/linux/scripts/util:/oe/master/scripts:/oe/master/build/tmp/sysroots/x86_64-linux/usr/bin/mipsel-nf-poky-linux:/oe/master/build/tmp/sysroots/p3367/usr/bin/crossscripts:/oe/master/build/tmp/sysroots/x86_64-linux/usr/sbin:/oe/master/build/tmp/sysroots/x86_64-linux/usr/bin:/oe/master/build/tmp/sysroots/x86_64-linux/sbin:/oe/master/build/tmp/sysroots/x86_64-linux/bin:/oe/master/scripts:/oe/master/bitbake/bin:/home/olofjn/bin:/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin:/var/cfengine/bin:/usr/local/mipsisa32r2el/r23/bin
>                 fi
>         fi
> 
>         machine_branch="${@ get_machine_branch(d, "master" )}"
> 
>         # ...
>         # trimmed down output
>         # ...
>  which triggered exception FetchError: Fetcher failure: Fetch command failed with exit code 1, output:
> + whoami
> + : whoami = root
> + id
> + : id = uid=0(root) gid=0(root) groups=0(root)
> + exit 1
> 
> ERROR: Task 100 (/oe/master/meta-porky/recipes-kernel/linux/linux-porky_3.10.bb, do_package_write_rpm) failed with exit code '1'
> 
> 
> Note that bitbake complains about do_patch, but the executed task
> is actually do_package_write_rpm. I'm not sure what this means.
> 
> Any ideas?

The log helps immensely since it shows its "Failure expanding variable
do_patch" so its not running do_patch, it is trying to expand the
variable for some reason when writing the rpm in do_package_write_rpm. 

Are you generating some kind of srpm differently from the normal
usecases?

Cheers,

Richard


