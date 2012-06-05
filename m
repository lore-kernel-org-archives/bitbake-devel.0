Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Kai.Kang@windriver.com>) id 1SbnyW-000808-Ue
	for bitbake-devel@lists.openembedded.org;
	Tue, 05 Jun 2012 09:14:45 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q5574FuC009176
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 5 Jun 2012 00:04:16 -0700 (PDT)
Received: from [128.224.162.164] (128.224.162.164) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server (TLS) id 14.1.255.0;
	Tue, 5 Jun 2012 00:04:15 -0700
Message-ID: <4FCDAF89.8000803@windriver.com>
Date: Tue, 5 Jun 2012 15:04:41 +0800
From: Kang Kai <Kai.Kang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To: "Wang, Shane" <shane.wang@intel.com>
References: <cover.1338866958.git.kai.kang@windriver.com>
	<df48506400665d5bb161559583327cbd94ce3eb7.1338866958.git.kai.kang@windriver.com>
	<3AB6CE7F274E534CAFD089D127A8A1FC23BCA57C@SHSMSX102.ccr.corp.intel.com>
In-Reply-To: <3AB6CE7F274E534CAFD089D127A8A1FC23BCA57C@SHSMSX102.ccr.corp.intel.com>
X-Originating-IP: [128.224.162.164]
X-MIME-Autoconverted: from 8bit to quoted-printable by mail1.windriver.com id
	q5574FuC009176
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
X-List-Received-Date: Tue, 05 Jun 2012 07:14:45 -0000
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

On 2012=E5=B9=B406=E6=9C=8805=E6=97=A5 14:42, Wang, Shane wrote:
>> -----Original Message-----
>> From: Kang Kai [mailto:kai.kang@windriver.com]
>> Sent: Tuesday, June 05, 2012 11:37 AM
>> To: dvhart@linux.intel.com
>> Cc: Wang, Shane; zhenfeng.zhao@windriver.com;
>> bitbake-devel@lists.openembedded.org
>> Subject: [PATCH 2/2] hob2: create a standalone deploy image tool
>>
>> [Yocto 2388]
>>
>> Create a standalone deploy image tool using the existing dialog
>> including DeployImageDialog and ImageSelectionDialog.
>>
>> Duplicate the gtk and pygtk versions check in the hob.py because this
>> will be run separately.
>>
>> Update ui/crumbs/utils.py that it needs to 'import bb' when run this
>> tool.
>>
>> Signed-off-by: Kang Kai<kai.kang@windriver.com>
>> ---
>>   bitbake/bin/bitbake-deployimage   |  135
>> +++++++++++++++++++++++++++++++++++++
>>   bitbake/lib/bb/ui/crumbs/utils.py |    1 +
>>   2 files changed, 136 insertions(+), 0 deletions(-)
>>   create mode 100755 bitbake/bin/bitbake-deployimage
>>
>> diff --git a/bitbake/bin/bitbake-deployimage
>> b/bitbake/bin/bitbake-deployimage
>> new file mode 100755
>> index 0000000..8fdd21b
>> --- /dev/null
>> +++ b/bitbake/bin/bitbake-deployimage
>> @@ -0,0 +1,135 @@
>> +#!/usr/bin/python
>> +
>> +
>> +requirements =3D "FATAL: Gtk+ 2.20.0 or higher, PyGtk version 2.22.0 =
or higher
>> and PyGobject are required to use Hob"

Hi Shane,

> Kai, I don't like you have this kind of limitation for GTK and PyGTK.
> Hob.py does have because we want special efforts on the visual componen=
ts. For this simple app,
> I don't want you to exclude a lot of users who only have lower versions.

Fine, I'll remove the version check.

>
>
>
>> diff --git a/bitbake/lib/bb/ui/crumbs/utils.py
>> b/bitbake/lib/bb/ui/crumbs/utils.py
>> index cd01a04..939864f 100644
>> --- a/bitbake/lib/bb/ui/crumbs/utils.py
>> +++ b/bitbake/lib/bb/ui/crumbs/utils.py
>> @@ -22,6 +22,7 @@
>>   # bitbake which will allow more flexibility.
>>
>>   import os
>> +import bb
> Why is this needed? I don't see any change you made in utils.py.
> Is that to say without this line, the functions in utils.py don't work?

Without the import, it just complains that

NameError: global name 'bb' is not defined

Regards,
Kai

>
>>   def which_terminal():
>>       term =3D bb.utils.which(os.environ["PATH"], "xterm")
>> --
>> 1.7.5.4
>



