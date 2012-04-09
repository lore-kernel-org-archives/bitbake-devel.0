Received: from mail-lpp01m010-f47.google.com ([209.85.215.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <raj.khem@gmail.com>) id 1SHJ9R-0003m2-HU
	for bitbake-devel@lists.openembedded.org;
	Mon, 09 Apr 2012 20:17:17 +0200
Received: by lagw12 with SMTP id w12so3407530lag.6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 Apr 2012 11:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type:content-transfer-encoding;
	bh=eTpurqm+mUTw5bNsONwqccJliC1V7CBagg0cnhxdCiU=;
	b=dD8WAIVlA4t4qMPPDc0hHiq62G3tWgzDM1ZPOb8z1JIQGUfPjD8PonjidUkkSOQ/CD
	5A7dioLX+WoNnjJE6vp71XC+tmEuh68bDHbuPOR3xggqwpuLx98o3JJwYM4BF7Z52COC
	NsttSEsmGqBwpBCxnGigNbByNeDymbaLqhDdpkJUl4bUNsEfOWv7TuVNrBRwA4VH/Wcx
	/ay3T35J2CRv/x+EWzZIgCx/lwJjeESC+I+ufpxIZwfMrSS3ShemMZaBj4YGtmTHo2uy
	Bb2WulvdmIKgy6NZQhQ3EQjOY8RwyEfYN1K4bTcPZQpmAEIK7eBJIqc4QGKNX1Wp7mfY
	0+Dw==
Received: by 10.152.146.234 with SMTP id tf10mr12585453lab.31.1333994880585;
	Mon, 09 Apr 2012 11:08:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.152.129.134 with HTTP; Mon, 9 Apr 2012 11:07:30 -0700 (PDT)
In-Reply-To: <4F82DE2E.30208@mlbassoc.com>
References: <4F82DE2E.30208@mlbassoc.com>
From: Khem Raj <raj.khem@gmail.com>
Date: Mon, 9 Apr 2012 11:07:30 -0700
Message-ID: <CAMKF1sr5t8DptrHBO6NdA0mh2URs6QVXgpfLSXMcFHW9ybX3jg@mail.gmail.com>
To: Gary Thomas <gary@mlbassoc.com>
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
X-List-Received-Date: Mon, 09 Apr 2012 18:17:17 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 9, 2012 at 6:03 AM, Gary Thomas <gary@mlbassoc.com> wrote:
> The config file conf/bblayers.conf seems to be required:
> =C2=A0$ bitbake core-image-minimal
> =C2=A0Unable to find conf/bblayers.conf
> =C2=A0BitBake must be run from within your build directory: /home/local/p=
60_poky
>
> but the bitbake documentation says otherwise:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<para>BitBake will=
 first search the current working directory
> for an optional "conf/bblayers.conf" configuration file. This file is
> expected to contain a BBLAYERS variable which is a space delimited list o=
f
> 'layer' directories. For each directory in this list, a "conf/layer.conf"
> file will be searched for and parsed with the LAYERDIR variable being set=
 to
> the directory where the layer was found. The idea is these files will set=
up
> BBPATH and other variables correctly for a given build directory
> automatically for the user.</para>
>
> Maybe the documentation should just read "required" instead of "optional"=
?

I think yes. Next action is a patch or bug report.


