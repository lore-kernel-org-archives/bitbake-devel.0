Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1Rkx1Z-0006Z9-M5
	for bitbake-devel@lists.openembedded.org;
	Wed, 11 Jan 2012 13:11:25 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 11 Jan 2012 04:02:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="95187533"
Received: from pgsmsx603.gar.corp.intel.com ([10.221.43.87])
	by orsmga001.jf.intel.com with ESMTP; 11 Jan 2012 04:02:49 -0800
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
	pgsmsx603.gar.corp.intel.com (10.221.43.87) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Wed, 11 Jan 2012 20:02:48 +0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.88]) by
	SHSMSX101.ccr.corp.intel.com ([169.254.1.60]) with mapi id
	14.01.0355.002; Wed, 11 Jan 2012 20:02:47 +0800
From: "Wang, Shane" <shane.wang@intel.com>
To: "Wang, Shane" <shane.wang@intel.com>, Richard Purdie
	<richard.purdie@linuxfoundation.org>, "Xu,
	Dongxiao" <dongxiao.xu@intel.com>
Thread-Topic: [bitbake-devel] [PATCH 7/8] command.py: add new command to get
	the CPU info
Thread-Index: AQHM0FT4BwoymbIowkKelKnxUv4P4ZYHC5gggAAFI0A=
Date: Wed, 11 Jan 2012 12:02:46 +0000
Message-ID: <3AB6CE7F274E534CAFD089D127A8A1FC0FCAA802@SHSMSX102.ccr.corp.intel.com>
References: <cover.1326249301.git.dongxiao.xu@intel.com>
	<d628d53679aa12f5803d0bbf30aa21ed3bc4779d.1326249301.git.dongxiao.xu@intel.com>
	<1326281642.23315.21.camel@ted>
	<3AB6CE7F274E534CAFD089D127A8A1FC0FCAA7DE@SHSMSX102.ccr.corp.intel.com>
In-Reply-To: <3AB6CE7F274E534CAFD089D127A8A1FC0FCAA7DE@SHSMSX102.ccr.corp.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 7/8] command.py: add new command to get the CPU info
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
X-List-Received-Date: Wed, 11 Jan 2012 12:11:25 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Wang, Shane wrote on=A02012-01-11:
>> I'm still not convinced
>> we should be setting any value for this though, or doing any bounds
>> checking on the value.
> Which value? We hope when the UI starts up, the UI can take advantage of
> cpus for build and set it as default.
> But users can change between 0 ~ max num of threads.

Do you mean the max is not necessary and we can't get accurate max actually=
?

--
Shane


