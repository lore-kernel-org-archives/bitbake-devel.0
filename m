Received: from mail-qc0-f175.google.com ([209.85.216.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1SHe7w-0008UO-41
	for bitbake-devel@lists.openembedded.org;
	Tue, 10 Apr 2012 18:41:08 +0200
Received: by qcso7 with SMTP id o7so3089162qcs.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Apr 2012 09:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type
	:content-transfer-encoding;
	bh=nXBWxV9I60imW7TWNPDApdDvPgSTGe3RJjt6PsI18uM=;
	b=Z5oxyJuYKmeVmoRwPlu3Vf3g9ELOcgYKuMQweOhmiPRzN3lYZZa/yA3wt3P1cu/Fiy
	wZf8jPaLh31WaPjDfhEFeEcKLIBhaS2MqOV+UZoG4AQBZdNZ9+OI//D+qhTDKJ1nAl4J
	RBg2HPGOE01OMld94uvOXE31ruYLFglbtx7dUzfbFAg6NWElGATLLz3HEFN15IKFrwHS
	I6X9Pw9vT+0KU2YvM6UnqK6ts98tEH0TuP+d/MHm7K4DVhDrWrel1lv0bzBc9GPUvsjR
	UshGJhvI7ELFQ725sXu1aOZdGLfnmIOTYRrrlD6kxp7TNdISbUO9W+d2QmzPytWEo95l
	CQ7Q==
Received: by 10.224.173.194 with SMTP id q2mr10698897qaz.15.1334075509765;
	Tue, 10 Apr 2012 09:31:49 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.229.79.79 with HTTP; Tue, 10 Apr 2012 09:31:29 -0700 (PDT)
In-Reply-To: <4F845B40.2040302@mvista.com>
References: <4F82DE2E.30208@mlbassoc.com>
	<CAMKF1sr5t8DptrHBO6NdA0mh2URs6QVXgpfLSXMcFHW9ybX3jg@mail.gmail.com>
	<4F845B40.2040302@mvista.com>
From: Chris Larson <clarson@kergoth.com>
Date: Tue, 10 Apr 2012 09:31:29 -0700
X-Google-Sender-Auth: Db9BW1ZtIzmG2BR6ZHFo1WmZ_TI
Message-ID: <CABcZAN=4SzW-7b75_ydFfT67uQhb_xq643v6o4AbvVbGxatJVA@mail.gmail.com>
To: Jeremy Puhlman <jpuhlman@mvista.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: bblayers.conf is required?
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
X-List-Received-Date: Tue, 10 Apr 2012 16:41:08 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 10, 2012 at 9:09 AM, Jeremy Puhlman <jpuhlman@mvista.com> wrote=
:
> On 4/9/2012 11:07 AM, Khem Raj wrote:
>> On Mon, Apr 9, 2012 at 6:03 AM, Gary Thomas <gary@mlbassoc.com> wrote:
>>> The config file conf/bblayers.conf seems to be required:
>>> =C2=A0$ bitbake core-image-minimal
>>> =C2=A0Unable to find conf/bblayers.conf
>>> =C2=A0BitBake must be run from within your build directory: /home/local=
/p60_poky
>>>
>>> but the bitbake documentation says otherwise:
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<para>BitBake wi=
ll first search the current working directory
>>> for an optional "conf/bblayers.conf" configuration file. This file is
>>> expected to contain a BBLAYERS variable which is a space delimited list=
 of
>>> 'layer' directories. For each directory in this list, a "conf/layer.con=
f"
>>> file will be searched for and parsed with the LAYERDIR variable being s=
et to
>>> the directory where the layer was found. The idea is these files will s=
etup
>>> BBPATH and other variables correctly for a given build directory
>>> automatically for the user.</para>
>>>
>>> Maybe the documentation should just read "required" instead of "optiona=
l"?
>>
>> I think yes. Next action is a patch or bug report.
>
> Hmmm you used to be able to run bitbake by just setting the BBPATH
> variable in the environment, and not need a bblayers file. It is not the
> suggested use case anymore, but looking at cooker I don't see anything
> in there in the layer handling code that would preclude that use.
>
> Also that final error message comes from the content bitbake script not
> bitbake proper.

Yeah, bitbake itself doesn't require bblayers.conf. If we *were* to
make the layer mechanism required by bitbake, then I'd say we should
implement it properly, rather than being a light convenience wrapper
around the use of BBPATH/BBFILES.
--=20
Christopher Larson


