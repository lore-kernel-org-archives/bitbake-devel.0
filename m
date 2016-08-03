Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 30F8560745
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  3 Aug 2016 15:24:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u73FNRxY021330; Wed, 3 Aug 2016 16:23:27 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id J8eTzm_BomLh; Wed,  3 Aug 2016 16:23:27 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u73FNLEw021322
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 3 Aug 2016 16:23:22 +0100
Message-ID: <1470237801.9142.134.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: =?UTF-8?Q?=E5=BC=A0=E5=BF=A0=E5=B1=B1?= <zzs213@126.com>, Robert Yang
	<liezhi.yang@windriver.com>, bitbake-devel@lists.openembedded.org
Date: Wed, 03 Aug 2016 16:23:21 +0100
In-Reply-To: <06719fa1-4361-f8d1-c4ef-c10534c3f1f3@126.com>
References: <360daea.d273.1564bad5108.Coremail.zzs213@126.com>
	<57A0B48A.6000606@windriver.com>
	<06719fa1-4361-f8d1-c4ef-c10534c3f1f3@126.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: Re: howto build specific version package
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
X-List-Received-Date: Wed, 03 Aug 2016 15:24:06 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Wed, 2016-08-03 at 14:14 +0800, 张忠山 wrote:
> 在 2016年08月02日 22:56, Robert Yang 写道:
> > Hi,
> > 
> > On 08/02/2016 10:34 PM, zzs wrote:
> > > 
> > > 
> > > Hello, everyone
> > > 
> > > I have two version .bb recipe, sya test_1.0.bb and test_2.0.bb.
> > > When build the `test` package  using the flowwing cmd:
> > >      bitbake test
> > > Always 2.0 was built.
> > > My question is: how to let bitbake to build version 1.0 of the
> > > test
> > > package
> > 
> > You can:
> > 1) PREFERRED_VERSION_test = "1.0" in conf file such as local.conf
> > Or:
> > 2) Set DEFAULT_PREFERENCE = "-1" in test_2.0.bb.
> > 
> > // Robert
> > 
> Thanks for your repley.
> 
> Your suggested method can select any version sure.
> 
> But whenever I finish  my project. some time later I wan't rebuilt
> this 
> project.
> Then I must edit the source to select specific version. It is not 
> convenient and buggy.
> Is there a way to select version that no need to edit the source,
> e.g. 
> select it on command line

You can't select everything from the commandline. Its for the reasons
of reproducibility that we suggest people set things in configuration
files like local.conf. You can then provide the exact configuration to
reproduce any given build by saving that configuration file.

Cheers,

Richard



