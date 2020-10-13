Subject: Re: [bitbake][dunfell][1.46][PATCH 1/2] bitbake: fetch/git: add support for SRC_URI containing spaces in url
To: bitbake-devel@lists.openembedded.org
From: "Charlie Davies" <charles.davies@whitetree.xyz>
X-Originating-Location: GB (185.217.117.101)
X-Originating-Platform: Linux Chrome 86
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Tue, 13 Oct 2020 14:44:48 -0700
References: <CAOSpxdZ-L_YBuB+urokrTuLNKdLBhnrc7xY41ubh_p03ZVxzSw@mail.gmail.com>
In-Reply-To: <CAOSpxdZ-L_YBuB+urokrTuLNKdLBhnrc7xY41ubh_p03ZVxzSw@mail.gmail.com>
Message-ID: <5402.1602625488617192663@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="Gs6zWc3ap1buToz3dmdB"

--Gs6zWc3ap1buToz3dmdB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Thank you for the feedback Enrico.

I agree that using shlex.quote() is a better method to implement this func=
tionality.

I have written a patch using shlex.quote() instead of escaped double quote=
s. I will run this patch through my local setup tonight before submitting i=
n the morning.

Steve, I will submit against master, dunfell and 1.46.

Charlie

--Gs6zWc3ap1buToz3dmdB
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Thank you for the feedback Enrico.<br /><br />I agree that using shlex.quot=
e() is a better method to implement this functionality.<br /><br />I have w=
ritten a patch using shlex.quote() instead of escaped double quotes. I will=
 run this patch through my local setup tonight before submitting in the mor=
ning.<br /><br />Steve, I will submit against master, dunfell and 1.46.<br =
/><br />Charlie

--Gs6zWc3ap1buToz3dmdB--
