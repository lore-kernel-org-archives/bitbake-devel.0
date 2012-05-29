Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SZOL3-0003r4-JX
	for bitbake-devel@lists.openembedded.org;
	Tue, 29 May 2012 17:28:01 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 29 May 2012 08:17:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="105436088"
Received: from azsmsx601.amr.corp.intel.com ([10.2.121.193])
	by AZSMGA002.ch.intel.com with ESMTP; 29 May 2012 08:17:19 -0700
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
	azsmsx601.amr.corp.intel.com (10.2.121.193) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Tue, 29 May 2012 08:17:19 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.133]) by
	SHSMSX101.ccr.corp.intel.com ([169.254.1.94]) with mapi id
	14.01.0355.002; Tue, 29 May 2012 23:17:17 +0800
From: "Wang, Shane" <shane.wang@intel.com>
To: "Wang, Shane" <shane.wang@intel.com>, Robert Yang
	<liezhi.yang@windriver.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 2/2] replace os.popen with
	subprocess.Popen
Thread-Index: AQHNNoUxFiFJBoGKBUmdMxvc+OGd8pbg6Q0AgAAFUTA=
Date: Tue, 29 May 2012 15:17:17 +0000
Message-ID: <3AB6CE7F274E534CAFD089D127A8A1FC23BB3A5D@SHSMSX102.ccr.corp.intel.com>
References: <cover.1337515887.git.liezhi.yang@windriver.com>
	<401cf2b62edc824883b8c7084f4f742e0b2d098c.1337515887.git.liezhi.yang@windriver.com>
	<3AB6CE7F274E534CAFD089D127A8A1FC23BB3A1C@SHSMSX102.ccr.corp.intel.com>
In-Reply-To: <3AB6CE7F274E534CAFD089D127A8A1FC23BB3A1C@SHSMSX102.ccr.corp.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: Kang Kai <Kai.Kang@windriver.com>,
	"Zhenfeng.Zhao@windriver.com" <Zhenfeng.Zhao@windriver.com>
Subject: Re: [PATCH 2/2] replace os.popen with subprocess.Popen
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
X-List-Received-Date: Tue, 29 May 2012 15:28:01 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Again, be careful to check whether "deploy image" and "run qemu" work.
Because previously I used "os.popen" and found the frontend process (i.e. t=
he Hob) hangs when the backend process (i.e. the deployment process and the=
 qemu process) is running.

So, I chose "subprocess.Popen", so please have a test with "deploy image" a=
nd "run qemu" after you replaced it.

--
Shane

Wang, Shane wrote on=A02012-05-29:

> Robert, be careful. Your patch 094742bed2fc01d55f572da946fcfa7a48521401
> has broke Hob.
>=20
> I am going to assign the bug
> https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D2511 to you and Kai.
>=20
> The error is:
> Traceback (most recent call last):
>   File
> "/home/yocto-build5/poky-contrib/bitbake/lib/bb/ui/crumbs/builder.py", li=
ne
> 821, in handler_build_started_cb
>     self.build_details_page.show_configurations(self.configuration,
> self.parameters)
>   File
> "/home/yocto-build5/poky-contrib/bitbake/lib/bb/ui/crumbs/builddetailspag=
e
> .py", line 336, in show_configurations
>     self.config_tv.show(configurations, params)
>   File
> "/home/yocto-build5/poky-contrib/bitbake/lib/bb/ui/crumbs/builddetailspag=
e
> .py", line 105, in show
>     f.close()
> AttributeError: 'str' object has no attribute 'close'
>




