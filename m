Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 1CC8A605D2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 Apr 2015 10:26:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t3OAQBqQ004981; Fri, 24 Apr 2015 11:26:11 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id fN5dWgMaCWa4; Fri, 24 Apr 2015 11:26:11 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t3OAPuRc004977
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 24 Apr 2015 11:26:07 +0100
Message-ID: <1429871156.26983.133.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>
Date: Fri, 24 Apr 2015 11:25:56 +0100
In-Reply-To: <a76c78db62cc1254387c8d4a556f0d8c54df704f.1429607216.git.liezhi.yang@windriver.com>
References: <cover.1429607216.git.liezhi.yang@windriver.com>
	<a76c78db62cc1254387c8d4a556f0d8c54df704f.1429607216.git.liezhi.yang@windriver.com>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] cooker.py: change working dir before use pyinotify
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
X-List-Received-Date: Fri, 24 Apr 2015 10:26:14 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2015-04-21 at 02:07 -0700, Robert Yang wrote:
> Fixed:
> $ cd tmp/work/core2-64-poky-linux/bash/4.3-r1
> $ bitbake bash -cclean
> 
> ERROR: Running idle function
> Traceback (most recent call last):
>   File "/buildarea/lyang1/poky/bitbake/lib/pyinotify.py", line 1317, in Notifier.process_events():
>                      continue
>     >            revent = self._sys_proc_fun(raw_event)  # system processings
>                  if watch_ and watch_.proc_fun:
>   File "/buildarea/lyang1/poky/bitbake/lib/pyinotify.py", line 686, in _SysProcessEvent.__call__(event=<_RawEvent cookie=0 mask=0x40000200 name=build wd=5 >):
>              # 3- default call method process_default
>     >        return self.process_default(event)
> 
>   File "/buildarea/lyang1/poky/bitbake/lib/pyinotify.py", line 897, in _SysProcessEvent.process_default(raw_event=<_RawEvent cookie=0 mask=0x40000200 name=build wd=5 >, to_append=None):
>                  dict_.update(to_append)
>     >        return Event(dict_)
> 
>   File "/buildarea/lyang1/poky/bitbake/lib/pyinotify.py", line 628, in Event.__init__(raw={'path': '.', 'wd': 5, 'mask': 1073742336, 'name': 'build', 'dir': True}):
>                      self.pathname = os.path.abspath(os.path.join(self.path,
>     >                                                             self.name))
>                  else:
>   File "/usr/lib/python2.7/posixpath.py", line 347, in abspath(path='./build'):
>              else:
>     >            cwd = os.getcwd()
>              path = join(cwd, path)
> OSError: [Errno 2] No such file or directory
> 
> And we can't run bitbake again:
> ERROR: Only one copy of bitbake should be run against a build directory
> 
> Chaneg working dir to TOPDIR rather than the dir which runs the command
> will fix the problem. Move self.initConfigurationData ahead, otherwise,
> there is no self.data.
> 
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> ---
>  bitbake/lib/bb/cooker.py |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> index 9c101f2..678a2f7 100644
> --- a/bitbake/lib/bb/cooker.py
> +++ b/bitbake/lib/bb/cooker.py
> @@ -121,6 +121,9 @@ class BBCooker:
>  
>          self.configuration = configuration
>  
> +        self.initConfigurationData()
> +        os.chdir(self.data.expand('${TOPDIR}'))

data.getVar("TOPDIR", True) please ;-)

Cheers,

Richard


