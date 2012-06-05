Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Kai.Kang@windriver.com>) id 1Sbrgn-0005BN-F3
	for bitbake-devel@lists.openembedded.org;
	Tue, 05 Jun 2012 13:12:41 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q558F9OB021096
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 5 Jun 2012 01:15:09 -0700 (PDT)
Received: from [128.224.162.164] (128.224.162.164) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server (TLS) id 14.1.255.0;
	Tue, 5 Jun 2012 01:15:09 -0700
Message-ID: <4FCDC027.5030304@windriver.com>
Date: Tue, 5 Jun 2012 16:15:35 +0800
From: Kang Kai <Kai.Kang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To: "Wang, Shane" <shane.wang@intel.com>
References: <cover.1338866958.git.kai.kang@windriver.com>
	<df48506400665d5bb161559583327cbd94ce3eb7.1338866958.git.kai.kang@windriver.com>
	<3AB6CE7F274E534CAFD089D127A8A1FC23BCA57C@SHSMSX102.ccr.corp.intel.com>
	<4FCDAF89.8000803@windriver.com>
	<3AB6CE7F274E534CAFD089D127A8A1FC23BCA684@SHSMSX102.ccr.corp.intel.com>
In-Reply-To: <3AB6CE7F274E534CAFD089D127A8A1FC23BCA684@SHSMSX102.ccr.corp.intel.com>
X-Originating-IP: [128.224.162.164]
X-MIME-Autoconverted: from 8bit to quoted-printable by mail.windriver.com id
	q558F9OB021096
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
	"zhenfeng.zhao@windriver.com" <zhenfeng.zhao@windriver.com>
Subject: Re: [PATCH 2/2] hob2: create a standalone deploy image tool
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
X-List-Received-Date: Tue, 05 Jun 2012 11:12:41 -0000
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

On 2012=E5=B9=B406=E6=9C=8805=E6=97=A5 15:40, Wang, Shane wrote:
> Kang Kai wrote on 2012-06-05:
>
>> On 2012=E5=B9=B406=E6=9C=8805=E6=97=A5 14:42, Wang, Shane wrote:
>>>> -----Original Message-----
>>>> From: Kang Kai [mailto:kai.kang@windriver.com]
>>>> Sent: Tuesday, June 05, 2012 11:37 AM
>>>> To: dvhart@linux.intel.com
>>>> Cc: Wang, Shane; zhenfeng.zhao@windriver.com;
>>>> bitbake-devel@lists.openembedded.org
>>>> Subject: [PATCH 2/2] hob2: create a standalone deploy image tool
>>>>
>>>> diff --git a/bitbake/lib/bb/ui/crumbs/utils.py
>>>> b/bitbake/lib/bb/ui/crumbs/utils.py
>>>> index cd01a04..939864f 100644
>>>> --- a/bitbake/lib/bb/ui/crumbs/utils.py
>>>> +++ b/bitbake/lib/bb/ui/crumbs/utils.py
>>>> @@ -22,6 +22,7 @@
>>>>    # bitbake which will allow more flexibility.
>>>>
>>>>    import os
>>>> +import bb
>>> Why is this needed? I don't see any change you made in utils.py.
>>> Is that to say without this line, the functions in utils.py don't wor=
k?
>> Without the import, it just complains that
>>
>> NameError: global name 'bb' is not defined
>>
>> Regards,
>> Kai
> OK, It seems Saul didn't test it when he created utils.py;-)

I am not quit sure because it is fine when call the deploy image in the=20
hob. little weird.

Regards,
Kai

>
> --
> Shane



