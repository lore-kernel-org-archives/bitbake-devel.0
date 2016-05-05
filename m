Return-Path: <mark.hatle@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 12D2965C5C
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  5 May 2016 16:51:32 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id u45GpW4E000612
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 5 May 2016 09:51:32 -0700 (PDT)
Received: from soho-mhatle-m.local (172.25.36.226) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.248.2;
	Thu, 5 May 2016 09:51:31 -0700
To: <bitbake-devel@lists.openembedded.org>
References: <20160505153158.GB2562@jama>
	<CABcZANmn5iVp3_rP-WOCeqbW=iykHTrJghmW+JaNnKigOVmkpw@mail.gmail.com>
From: Mark Hatle <mark.hatle@windriver.com>
Organization: Wind River Systems
Message-ID: <ad29d5a7-462f-6491-cd5c-adae43171c95@windriver.com>
Date: Thu, 5 May 2016 11:51:31 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
	Gecko/20100101 Thunderbird/45.0
MIME-Version: 1.0
In-Reply-To: <CABcZANmn5iVp3_rP-WOCeqbW=iykHTrJghmW+JaNnKigOVmkpw@mail.gmail.com>
Subject: Re: lsof fails with python exception when bitbake is finished
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
X-List-Received-Date: Thu, 05 May 2016 16:51:35 -0000
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit

On 5/5/16 11:29 AM, Christopher Larson wrote:
> 
> On Thu, May 5, 2016 at 8:31 AM, Martin Jansa <martin.jansa@gmail.com
> <mailto:martin.jansa@gmail.com>> wrote:
> 
>     I haven't checked what leads to this error, but with latest oe-core and bitbake
>     I've noticed ugly python exception after successful build with bitbake:
> 
> 
>     Summary: There were 35 WARNING messages shown.
>     Process ProcessServer-1:
>     Traceback (most recent call last):
>       File "/usr/lib/python2.7/multiprocessing/process.py", line 258, in _bootstrap
>         self.run()
>       File "/OE/bitbake/lib/bb/server/process.py", line 104, in run
>         bb.cooker.server_main(self.cooker, self.main)
>       File "/OE/bitbake/lib/bb/cooker.py", line 1692, in server_main
>         cooker.post_serve()
>       File "/OE/bitbake/lib/bb/cooker.py", line 1627, in post_serve
>         procs = subprocess.check_output(["lsof", '-w', lockfile],
>     stderr=subprocess.STDOUT)
>       File "/usr/lib/python2.7/subprocess.py", line 573, in check_output
>         raise CalledProcessError(retcode, cmd, output=output)
>     CalledProcessError: Command '['lsof', '-w', '/OE/bitbake.lock']' returned
>     non-zero exit status 1
>     /OE/$ lsof -w /OE/bitbake.lock
>     /OE/$ echo $?
>     1
>     /OE/$ ls -lah bitbake.lock
>     -rw-rw-r-- 1 mjansa mjansa 0 May  5 13:19 bitbake.lock
> 
> 
> I'd suggest catching that exception at 1627 of cooker.py and at least printing
> exc.output, so we can see if lsof showed any errors.

We recently found this as well.  In our case it turns out we have a process
(background) that was started by a special feature of our build.  (similar to
the pseudo daemon, but with a 60 second timeout.)  This kept the lock file open,
and 9 times out of 10, we'd end the build with the typical waiting on a process
message, but very now and then we'd get the lsof you saw.

(we fixed it by closing the fd's on the fork/exec for the background item.)

--Mark

> -- 
> Christopher Larson
> clarson at kergoth dot com
> Founder - BitBake, OpenEmbedded, OpenZaurus
> Maintainer - Tslib
> Senior Software Engineer, Mentor Graphics
> 
> 


