Received: from mail-tul01m020-f175.google.com ([209.85.214.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <oren@ephemeron-labs.com>) id 1S3g7M-0000aV-VG
	for bitbake-devel@lists.openembedded.org;
	Sat, 03 Mar 2012 04:58:49 +0100
Received: by obqv19 with SMTP id v19so2994262obq.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 02 Mar 2012 19:50:16 -0800 (PST)
Received-SPF: pass (google.com: domain of oren@ephemeron-labs.com designates
	10.182.109.106 as permitted sender) client-ip=10.182.109.106; 
Authentication-Results: mr.google.com; spf=pass (google.com: domain of
	oren@ephemeron-labs.com designates 10.182.109.106 as permitted
	sender) smtp.mail=oren@ephemeron-labs.com
Received: from mr.google.com ([10.182.109.106])
	by 10.182.109.106 with SMTP id hr10mr5166985obb.27.1330746616695
	(num_hops = 1); Fri, 02 Mar 2012 19:50:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.182.109.106 with SMTP id hr10mr4446858obb.27.1330746616595;
	Fri, 02 Mar 2012 19:50:16 -0800 (PST)
Received: by 10.182.19.7 with HTTP; Fri, 2 Mar 2012 19:50:16 -0800 (PST)
X-Originating-IP: [76.99.59.229]
In-Reply-To: <3AB6CE7F274E534CAFD089D127A8A1FC23ADFC53@SHSMSX102.ccr.corp.intel.com>
References: <cover.1330523904.git.shane.wang@intel.com>
	<4F4E9837.7080602@linux.intel.com>
	<3AB6CE7F274E534CAFD089D127A8A1FC23ADFC53@SHSMSX102.ccr.corp.intel.com>
Date: Fri, 2 Mar 2012 22:50:16 -0500
Message-ID: <CALvD2LjJS-6eN23b_SbCWjZX8gzyv6yfsEa4JEKBXaB6S7JDHA@mail.gmail.com>
From: Oren Leaffer <oren@ephemeron-labs.com>
To: "Wang, Shane" <shane.wang@intel.com>
X-Gm-Message-State: ALoCoQllYEsqGwxjpmtjz7U2hyuR1NWMKrxloctrhhGeBPW68QwRgsdkE2oQG/IRfBma/ctJArm+
Cc: "An, LimingX L" <limingx.l.an@intel.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 00/32] Hob related fixes
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
X-List-Received-Date: Sat, 03 Mar 2012 03:58:49 -0000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Shane,

As I understand it, if you need keep track of indices as you go
through a list, then enumerate() is the python way to do it.
http://docs.python.org/library/functions.html#enumerate

So you would have:

for i, item in enumerate(list):
   ... etc


Best regards,


Oren

On Fri, Mar 2, 2012 at 1:48 AM, Wang, Shane <shane.wang@intel.com> wrote:
> Joshua Lock wrote on=A02012-03-01:
>> One thing I did notice whilst reviewing this series is that there's a
>> lot of this anti-pattern in the hob 2 code:
>> =A0 =A0 =A0 for i in range(len(mylist)):
>> rather than:
>> =A0 =A0 =A0 for item in list:
>>
>> Can we make an effort to tidy those up?
> I will check those later. I went through them quickly.
> Some of them are because the code refers to the index i.
>
> Otherwise, we would have the code.
> i =3D 0
> for item in list:
> =A0XXXXX
> =A0XXX =3D i
> =A0i +=3D 1
>
> which also looks not perfect. But anyway, I will check all of them later =
and send another patch for improvement.
> If there is no reference to the index, I will replace with your style.
>
> --
> Shane
>
>>
>> Cheers,
>> Joshua
>
>
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel


