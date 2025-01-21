Return-Path: <egyszeregy@freemail.hu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E07BC02182
	for <webhook@archiver.kernel.org>; Tue, 21 Jan 2025 16:28:34 +0000 (UTC)
Subject: Re: [PATCH] bitbake: knotty/progressbar: Optimize footer update and prints
To: bitbake-devel@lists.openembedded.org
From: "Livius" <egyszeregy@freemail.hu>
X-Originating-Location: =?UTF-8?B?U3R1dHRnYXJ0LCBCYWRlbi1Xw7xydHRlbWJlcmcsIERF?= (194.39.218.18)
X-Originating-Platform: Windows Chrome 131
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Tue, 21 Jan 2025 08:28:24 -0800
References: <71994b37eb818538690cdd5a810cecacec887b8c.camel@linuxfoundation.org>
In-Reply-To: <71994b37eb818538690cdd5a810cecacec887b8c.camel@linuxfoundation.org>
Message-ID: <20973.1737476704621906904@lists.openembedded.org>
X-Old-Date: Tue, 21 Jan 2025 08:27:34 -0800
Content-Type: multipart/alternative; boundary="q21uxEQjlUZGUucq0sgy"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 Jan 2025 16:28:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17043
Message-ID: <20250121162824.2EOqwH777-W8yDrH5r8fg_GY5leNyif48gVfp5zRx48@z>

--q21uxEQjlUZGUucq0sgy
Content-Type: text/plain; charset="utf-8"; markup=markdown
Content-Transfer-Encoding: quoted-printable

- `fd` numbering:

    https://learning.lpi.org/en/learning-materials/101-500/103/103.4/103.4_=
01/

    *Standard Linux processes have three communication channels opened by d=
efault: the standard input channel (most times simply called stdin), the st=
andard output channel (stdout) and the standard error channel (stderr). The=
 numerical file descriptors assigned to these channels are 0 to stdin, 1 to=
 stdout and 2 to stderr.*

    It seems to me they are always 1 and 2, but maybe it would better to us=
e `sys.stdout.fileno()` and `sys.stderr.fileno()` for comparing. This is ne=
ed to use for checking that is `fd` is resizable or not.

    https://stackoverflow.com/questions/32199552/what-is-sys-stdin-fileno-i=
n-python

- `self._fd_console` needed to introduce as a dedicated `fd` for resizable =
`fd`s in order to be possible to set `self.fd` to a `StrinIO` object after =
the constructor in outside.
- There are many hot Python topics about what is the best to use for printi=
ng in loops and cycles. Following are the facts:

    Best: `"\n".join(msgbuf_list)` or `write()` to a `StringIO`, they do no=
t perform any I/O operation for HWs
   =20
    Absolute worst: `print()` in each cycle

- `print()` redirect to `StringIO`

    It is the same as write to `StringIO` directly as a i know, but i liked=
 to keep the old `print()` style to understand better.
   =20
    `print(content, file=3Dself._footer_buf)` -> `self._footer_buf.write(f"=
{content}\n")`

--q21uxEQjlUZGUucq0sgy
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<ul>
<li><p><code>fd</code> numbering:</p>

<p><a href=3D"https://learning.lpi.org/en/learning-materials/101-500/103/10=
3.4/103.4_01/" target=3D"_blank">https://learning.lpi.org/en/learning-mater=
ials/101-500/103/103.4/103.4_01/</a></p>

<p><em>Standard Linux processes have three communication channels opened by=
 default: the standard input channel (most times simply called stdin), the =
standard output channel (stdout) and the standard error channel (stderr). T=
he numerical file descriptors assigned to these channels are 0 to stdin, 1 =
to stdout and 2 to stderr.</em></p>

<p>It seems to me they are always 1 and 2, but maybe it would better to use=
 <code>sys.stdout.fileno()</code> and <code>sys.stderr.fileno()</code> for =
comparing. This is need to use for checking that is <code>fd</code> is resi=
zable or not.</p>

<p><a href=3D"https://stackoverflow.com/questions/32199552/what-is-sys-stdi=
n-fileno-in-python" target=3D"_blank">https://stackoverflow.com/questions/3=
2199552/what-is-sys-stdin-fileno-in-python</a></p></li>

<li><p><code>self._fd_console</code> needed to introduce as a dedicated <co=
de>fd</code> for resizable <code>fd</code>s in order to be possible to set =
<code>self.fd</code> to a <code>StrinIO</code> object after the constructor=
 in outside.</p></li>

<li><p>There are many hot Python topics about what is the best to use for p=
rinting in loops and cycles. Following are the facts:</p>

<p>Best: <code>&quot;\n&quot;.join(msgbuf_list)</code> or <code>write()</co=
de> to a <code>StringIO</code>, they do not perform any I/O operation for H=
Ws</p>

<p>Absolute worst: <code>print()</code> in each cycle</p></li>

<li><p><code>print()</code> redirect to <code>StringIO</code></p>

<p>It is the same as write to <code>StringIO</code> directly as a i know, b=
ut i liked to keep the old <code>print()</code> style to understand better.=
</p>

<p><code>print(content, file=3Dself._footer_buf)</code> -&gt; <code>self._f=
ooter_buf.write(f&quot;{content}\n&quot;)</code></p></li>
</ul>

--q21uxEQjlUZGUucq0sgy--

