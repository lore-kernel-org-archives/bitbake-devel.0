Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1S14US-00054C-0R for bitbake-devel@lists.openembedded.org;
	Sat, 25 Feb 2012 00:23:52 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q1ONFTBq014830;
	Fri, 24 Feb 2012 23:15:29 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 13974-08; Fri, 24 Feb 2012 23:15:25 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q1ONFJoH014824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 24 Feb 2012 23:15:20 GMT
Message-ID: <1330125319.9617.14.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Martin Jansa <martin.jansa@gmail.com>
Date: Fri, 24 Feb 2012 23:15:19 +0000
In-Reply-To: <20120224211914.GN3769@jama.jama.net>
References: <20120224211914.GN3769@jama.jama.net>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: KeyError in siggen.py
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
X-List-Received-Date: Fri, 24 Feb 2012 23:23:52 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2012-02-24 at 22:19 +0100, Martin Jansa wrote:
> Any idea what could cause this?
> 
> OE qemux86-64@ ~/oe-core $ bitbake -c configure -b /OE/oe-core/openembedded-core/meta/recipes-devtools/gcc/gcc-cross-initial_4.6.bb -f
> WARNING: Buildfile specified, dependencies will not be handled. If this is not what you want, do not use -b / --buildfile.
> ERROR: Command execution failed: Traceback (most recent call last):
>   File "/usr/lib64/python2.7/site-packages/bb/command.py", line 87, in runAsyncCommand
>     commandmethod(self.cmds_async, self, options)
>   File "/usr/lib64/python2.7/site-packages/bb/command.py", line 203, in buildFile
>     command.cooker.buildFile(bfile, task)
>   File "/usr/lib64/python2.7/site-packages/bb/cooker.py", line 1076, in buildFile
>     bb.build.del_stamp('do_%s' % task, self.status, fn)
>   File "/usr/lib64/python2.7/site-packages/bb/build.py", line 441, in del_stamp
>     stamp = stamp_internal(task, d, file_name)
>   File "/usr/lib64/python2.7/site-packages/bb/build.py", line 411, in stamp_internal
>     stamp = bb.parse.siggen.stampfile(stamp, file_name, taskname, extrainfo)
>   File "/usr/lib64/python2.7/site-packages/bb/siggen.py", line 222, in stampfile
>     h = self.taskhash[k]
> KeyError: '/OE/oe-core/openembedded-core/meta/recipes-devtools/gcc/gcc-cross-initial_4.6.bb.do_configure'

The -f triggers a del_stamp so I'm looking at that with suspicion...

No fix but I suspect its where we need to look. I can reproduce with -b
and -f combined.

Cheers,

Richard



