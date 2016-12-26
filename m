Return-Path: <mhalstead@linuxfoundation.org>
Received: from mail-pg0-f49.google.com (mail-pg0-f49.google.com [74.125.83.49])
	by mail.openembedded.org (Postfix) with ESMTP id 8E50F71CA7
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Dec 2016 04:06:52 +0000 (UTC)
Received: by mail-pg0-f49.google.com with SMTP id f188so130702411pgc.3
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 25 Dec 2016 20:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=subject:to:references:from:organization:message-id:date:user-agent
	:mime-version:in-reply-to;
	bh=R0s/J48cqKZipvOO0eUEw9VF8kl0LLe001M30gD/Smk=;
	b=LsTfBqMlisITQnmn5dUaUh3uBTe+nHhHQ2i70iOJf53D6INnSiFeP2f+ywazGdA6zv
	Qws8mS28CjWEyFtVViRt6M0EDfS5tkPBBnhveXHDpcorotfEsoVRlezdV7a7yJP5scHA
	SRcF0CMKPozLo2JW6lchIjmyc9y5dRyZmygKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:organization
	:message-id:date:user-agent:mime-version:in-reply-to;
	bh=R0s/J48cqKZipvOO0eUEw9VF8kl0LLe001M30gD/Smk=;
	b=nd9w+fKjeTEZmGVL3U3N3/SokWhbAXeZzIxvF6opMjV5EKSaq/DZ0c74lQi8SO1Yg+
	yx2zFCkC+3ZM1GgwYfcLg4S9DKnlmt9bkxUB6XBjKM4oPOvsyf9GYwTVaVuzdPEaBF7r
	dvAKElAKGAIrPFrDf1E9t8uFNgkWAHjz8M2MvWnPdLTviD0r+79cGZQv8Co1nhoy/wvY
	pXBXz/KnJNKB5huO7X3FHvJD3Axb1c1OL6b99V20YkESZFGsIc2gy6uSeeBU3q2+nVMU
	cHATvML9pHVcG9PTDG9P+BaZd3mezj6JUyE/2iyopjt8aRDK4HD7Y9iWJz1b49u1Hulg
	xQ7w==
X-Gm-Message-State: AIkVDXLst8JsCbvnQ07iZvta2kwCZK39n7AMnnyiPrlwuzNea19xE6EdVO6cc/gJwo9Tvl/7
X-Received: by 10.98.75.75 with SMTP id y72mr18694153pfa.23.1482725214045;
	Sun, 25 Dec 2016 20:06:54 -0800 (PST)
Received: from yct-lpt.lan (50-39-165-77.bvtn.or.frontiernet.net.
	[50.39.165.77]) by smtp.gmail.com with ESMTPSA id
	q190sm37809398pfb.51.2016.12.25.20.06.52
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 25 Dec 2016 20:06:52 -0800 (PST)
To: openembedded-devel@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org,
	yocto-infrastructure@yoctoproject.org, yocto@yoctoproject.org
References: <CAHQecY48gVbt4S+88MHivSbv-Xdn29WRq5RPL6+QDVGYUPCwYw@mail.gmail.com>
	<E628426E-84F8-4EA4-A296-D32C3339DF1C@gmail.com>
	<CAHQecY4oXXwGeLsdXrgjFmouTiwvsJXa6K1Qbp--9WZ0=3O5CQ@mail.gmail.com>
From: Michael Halstead <mhalstead@linuxfoundation.org>
Organization: Linux Foundation
Message-ID: <74b16359-8b63-4f34-b9b7-618bd8aa4cb6@linuxfoundation.org>
Date: Sun, 25 Dec 2016 20:06:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
	Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <CAHQecY4oXXwGeLsdXrgjFmouTiwvsJXa6K1Qbp--9WZ0=3O5CQ@mail.gmail.com>
Subject: Re: [oe] Infra Full Stop 12/26-12/29
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
X-List-Received-Date: Mon, 26 Dec 2016 04:06:54 -0000
X-Groupsio-MsgNum: 8320
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="G0Te5ffCPFULSUrNKPVioCe1IhmMF47fO"

--G0Te5ffCPFULSUrNKPVioCe1IhmMF47fO
Content-Type: multipart/mixed; boundary="hGHMl4sm8WLEwn8j8M6ClWp8pHbmKlLKT";
 protected-headers="v1"
From: Michael Halstead <mhalstead@linuxfoundation.org>
To: openembedded-devel@lists.openembedded.org,
 bitbake-devel@lists.openembedded.org, yocto-infrastructure@yoctoproject.org,
 yocto@yoctoproject.org
Message-ID: <74b16359-8b63-4f34-b9b7-618bd8aa4cb6@linuxfoundation.org>
Subject: Re: [oe] Infra Full Stop 12/26-12/29
References: <CAHQecY48gVbt4S+88MHivSbv-Xdn29WRq5RPL6+QDVGYUPCwYw@mail.gmail.com>
 <E628426E-84F8-4EA4-A296-D32C3339DF1C@gmail.com>
 <CAHQecY4oXXwGeLsdXrgjFmouTiwvsJXa6K1Qbp--9WZ0=3O5CQ@mail.gmail.com>
In-Reply-To: <CAHQecY4oXXwGeLsdXrgjFmouTiwvsJXa6K1Qbp--9WZ0=3O5CQ@mail.gmail.com>

--hGHMl4sm8WLEwn8j8M6ClWp8pHbmKlLKT
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

In preparation for the scheduled maintenance I have moved
git.openembedded.org to a new server temporarily. E-mail and Patchwork
hooks may not work correctly. All other git operations as well as
listings at http://git.openembedded.org/ should continue working.

If you have a git remote pointed directly at openembedded.org it will
fail. Please update your remote to point at git.openembedded.org and try
again.

Other services that will stay up during the maintenance are:

Layerindex https://layers.openembedded.org/
Mailman http://lists.openembedded.org/
Patchwork https://patchwork.openembedded.org/

I'd like the share my appreciation for the OpenEmbedded volunteer
sysadmins who are taking time away from their holiday celebrations to
make this downtime as convenient for the rest of us as possible.


On 12/22/2016 09:19 AM, Tom King wrote:
> Schedule is  06:00UTC 27DEC16 for the full stop.  Things will start com=
ing
> back (estimated) about 48hrs later.
>
> Tom
>
> On Tue, Dec 20, 2016 at 11:16 AM, Khem Raj <raj.khem@gmail.com> wrote:
>
>>> On Dec 20, 2016, at 10:50 AM, Tom King <ka6sox@gmail.com> wrote:
>>>
>>> Hi All,
>>>
>>> We have been looking for a time when we could do a full stop of the i=
nfra
>>> to upgrade some bits and clear out some faults.
>>>
>>> This will involve shutting down the main machine that we use for *mos=
t*
>> of
>>> the OE infra.
>>>
>>> Our goal is to put up a backup git master but other services such as:=

>> wiki,
>>> patches, etc will be offline for some or all of that period.
>>>
>>> We have delayed doing this much needed maintenance to try to work aro=
und
>>> Yocto and OE release schedules and it is necessary that we take this =
time
>>> to do the work.
>>>
>> I guess, you need to come up with a tentative down-time schedule.
>>
>>> Tom
>>> (for the OE Infra Team)
>>> --
>>> _______________________________________________
>>> Openembedded-devel mailing list
>>> Openembedded-devel@lists.openembedded.org
>>> http://lists.openembedded.org/mailman/listinfo/openembedded-devel
>> --
>> _______________________________________________
>> Openembedded-devel mailing list
>> Openembedded-devel@lists.openembedded.org
>> http://lists.openembedded.org/mailman/listinfo/openembedded-devel
>>

--=20
Michael Halstead
Linux Foundation / SysAdmin



--hGHMl4sm8WLEwn8j8M6ClWp8pHbmKlLKT--

--G0Te5ffCPFULSUrNKPVioCe1IhmMF47fO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYYJdbAAoJEGpkljW6QlqVmuQP/j9rqDXE6QBpYP34ycYWcCWF
M7JRwEHsCe/PdR1VNrRJq7XTQy21zYKmBGf3NkWUUwWWvsXaXQ1vxuUGTVBsXMLt
m+fCak6zwQhcTRV5qGnwIow3Pze0G4QHsRx8FUKGbTksLXTG01OzNfIL0TCmO38s
qOmNrtBhP5Jc/mJMuLGDLDlx9KodoVAr8vVxqM/aTj6PvbtZYoJeIxCGEgdhyyj0
IAOA+1xvH/RMrtzL/oTOa9KKYHbGRaF5aZou8M+M4JaGQTma+oPb07dS8annYBdU
S0/8Wu0c1v0AoepW6ENkR1g1YLZH+9QNekrFlhiTDp95iVhap0mq2nP1t8kX2i/x
zDKD1rBow0pii9qz0/ixfsoRSn1J9ehfifo/g4tqOaJTqNPkxDelceD4JpOOX8Dj
gUh+TtHOmZnGvTESyzjsNNVuByqdXwLgJXYW7WcksUu94yk+nj6n3b9eWMRMGVsj
Q9snNncX/JiJmBSdEEIr9eFqJi0+ON5hkj7HK19jPFfrqA6hHdICH0Wt1zecPoHN
eLMI2cToaJ1YjZYElo0cldf8jwBjT13rS7tt+rHg+B/IHnM6oCblF6kB99/WtNeI
z41qhnAbwZsskcUTcMRdtLg5Km4qjSr8dCU6fiGif76GUe/1s8oJWzoihtqTcYY0
6xWgTf7YPevOsMFSj1Zp
=SX9n
-----END PGP SIGNATURE-----

--G0Te5ffCPFULSUrNKPVioCe1IhmMF47fO--
