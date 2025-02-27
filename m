Return-Path: <Alexandre.Marques@criticaltechworks.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FC9C021B8
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 00:42:35 +0000 (UTC)
Subject: Re: Clarification on Cleaning Up a Remote Hash Equivalence DB
To: bitbake-devel@lists.openembedded.org
From: "Alexandre Marques" <Alexandre.Marques@criticaltechworks.com>
X-Originating-Location: Vila Nova de Foz Coa, Guarda, PT (213.205.68.220)
X-Originating-Platform: Linux Firefox 135
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Wed, 26 Feb 2025 16:42:25 -0800
References: <CAJdd5GZtxMRQB=VyEms8cS+1BjHxpDWZ8BZgPdvwQmYA8oy=7Q@mail.gmail.com>
In-Reply-To: <CAJdd5GZtxMRQB=VyEms8cS+1BjHxpDWZ8BZgPdvwQmYA8oy=7Q@mail.gmail.com>
Message-ID: <16993.1740616945379904359@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="uzSEjyXFooEqO3wsiAq2"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Feb 2025 00:42:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17334

--uzSEjyXFooEqO3wsiAq2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 08:08 AM, Joshua Watt wrote:

>=20
> On Wed, Feb 26, 2025 at 2:51=E2=80=AFAM Alexandre Marques
> <Alexandre.Marques@criticaltechworks.com> wrote:
>=20
>> It already does this. If you specify multiple KEY VALUE pairs on the
>> command line, it will send all of them to the server in a single
>> message.
>>=20
>> Well yes, but as far as I understand, keys get overwritten, and the key =
is
>> the actual db column, meaning we can't really pass multiple hashes, just
>> "refine" the query.
>>=20
>> For example:
>> Client Side:
>> $ ./bitbake-hashclient --address localhost:8688 gc-mark alive --where
>> taskhash 9cd45da2fb6aa303a7828ec3cad7709bde2882422792e696016663f390aeece=
0
>> New hashes marked: 1
>>=20
>> $ ./bitbake-hashclient --address localhost:8688 gc-mark alive --where
>> taskhash f1c4cca2ea1fc1181c40afc8518d75db42d5c5e841fc4a4dbdcba30e1a9879e=
0
>> New hashes marked: 1
>>=20
>> $ ./bitbake-hashclient --address localhost:8688 gc-mark alive --where
>> taskhash 9cd45da2fb6aa303a7828ec3cad7709bde2882422792e696016663f390aeece=
0
>> --where taskhash
>> f1c4cca2ea1fc1181c40afc8518d75db42d5c5e841fc4a4dbdcba30e1a9879e0
>> New hashes marked: 1
>>=20
>> $ ./bitbake-hashclient --address localhost:8688 gc-mark alive --where
>> taskhash 9cd45da2fb6aa303a7828ec3cad7709bde2882422792e696016663f390aeece=
0
>> --where taskhash2
>> f1c4cca2ea1fc1181c40afc8518d75db42d5c5e841fc4a4dbdcba30e1a9879e0
>> New hashes marked: 1
>>=20
>> Server Side:
>> {'mark': 'alive', 'where': {'taskhash':
>> '9cd45da2fb6aa303a7828ec3cad7709bde2882422792e696016663f390aeece0'}}
>> {'mark': 'alive', 'where': {'taskhash':
>> 'f1c4cca2ea1fc1181c40afc8518d75db42d5c5e841fc4a4dbdcba30e1a9879e0'}}
>> {'mark': 'alive', 'where': {'taskhash':
>> 'f1c4cca2ea1fc1181c40afc8518d75db42d5c5e841fc4a4dbdcba30e1a9879e0'}}
>> {'mark': 'alive', 'where': {'taskhash':
>> '9cd45da2fb6aa303a7828ec3cad7709bde2882422792e696016663f390aeece0',
>> 'taskhash2':
>> 'f1c4cca2ea1fc1181c40afc8518d75db42d5c5e841fc4a4dbdcba30e1a9879e0'}}
>>=20
>> Perhaps I'm missing a something..
>> What I was proposing would be supporting something similar to this:
>> Client Side:
>> $ ./bitbake-hashclient --address localhost:8688 gc-mark alive --where
>> 9cd45da f1c4cca
>>=20
>> Server Side:
>> {'mark': 'alive', 'where': {'taskhash': ['9cd45da', 'f1c4cca']}}
>=20
> No, you aren't missing anything, I was incorrect :)
>=20
> There are 2 approaches here.
>=20
> The first would be to improve bitbake-hashclient to add the input
> stream command, but keep the existing API with the server. Each mark
> sent through the file/pipe would result in a separate `mark` command
> being sent to the server. This should still be faster since it will
> reuse the same connection to the server as long as bitbake-hashclient
> is running, which will save the overhead of establishing and
> negotiating a connection. This also has the advantage that it doesn't
> require server side changes, but it does mean a round-trip for each
> `mark` command

I have a simple POC for this first approach, and seems to be working fine.
I still need to test with the remote server to have a better sense of how
much faster it is, but based on my tests with a local server, I expect it t=
o
still be in the "minutes".

>=20
> The second is to make a new server API to allow streaming of marks.
> The protocol between the client and server allows commands to go into
> a "stream" mode (which to be clear is distinct from the "input stream"
> discussed above, the name overlap is unfortunate). This mode allows
> the client to send newline delimited messages as fast as it wants
> (usually is some large batch size), and asynchronously read the
> responses from the server (see send_stream_batch() in the client
> code), allowing multiple messages to be in-flight at once.
> Implementing a new mark API on the server using this mechanism would
> be the fastest possible way of communicating the marks. Of course the
> disadvantage here is that it would require new API on the server, so a
> server upgrade would be required to use it. That said, it may be
> possible to make bitbake-hashclient intelligent enough to know if this
> new API exists and if so use it for the "input stream" and if not
> fallback to the older messages as described above

I haven't tried the "stream mode" yet, but had a quick look at the code and=
 I
don't see any obvious reason for it not to work. :) so thanks!!

I've been trying to tackle this "make bitbake-hashclient intelligent enough=
 to know
if this new API exists" and tbh I'm struggling a bit..

Whenever I use a command that isn't available on the server I just get "Err=
or talking
to server: Connection closed". So far I'm not really seeing a way of gettin=
g more
info on the particular error, and blindly assume a "connection closed" mean=
s the
new API is not available does not seem right.

I was thinking of adding a new command to the server to "request the API", =
or check
if a particular command is available, but that in itself changes the API :,=
)
so its a bit chicken and egg, which makes me think this might not be the aw=
ay to go..

--uzSEjyXFooEqO3wsiAq2
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>On Wed, Feb 26, 2025 at 08:08 AM, Joshua Watt wrote:</div>
<div>
<blockquote>On Wed, Feb 26, 2025 at 2:51=E2=80=AFAM Alexandre Marques<br />=
&lt;Alexandre.Marques@criticaltechworks.com&gt; wrote:<br />
<blockquote>It already does this. If you specify multiple KEY VALUE pairs o=
n the<br />command line, it will send all of them to the server in a single=
<br />message.<br /><br />Well yes, but as far as I understand, keys get ov=
erwritten, and the key is the actual db column, meaning we can't really pas=
s multiple hashes, just "refine" the query.<br /><br />For example:<br />Cl=
ient Side:<br />$ ./bitbake-hashclient --address localhost:8688 gc-mark ali=
ve --where taskhash 9cd45da2fb6aa303a7828ec3cad7709bde2882422792e696016663f=
390aeece0<br />New hashes marked: 1<br /><br />$ ./bitbake-hashclient --add=
ress localhost:8688 gc-mark alive --where taskhash f1c4cca2ea1fc1181c40afc8=
518d75db42d5c5e841fc4a4dbdcba30e1a9879e0<br />New hashes marked: 1<br /><br=
 />$ ./bitbake-hashclient --address localhost:8688 gc-mark alive --where ta=
skhash 9cd45da2fb6aa303a7828ec3cad7709bde2882422792e696016663f390aeece0 --w=
here taskhash f1c4cca2ea1fc1181c40afc8518d75db42d5c5e841fc4a4dbdcba30e1a987=
9e0<br />New hashes marked: 1<br /><br />$ ./bitbake-hashclient --address l=
ocalhost:8688 gc-mark alive --where taskhash 9cd45da2fb6aa303a7828ec3cad770=
9bde2882422792e696016663f390aeece0 --where taskhash2 f1c4cca2ea1fc1181c40af=
c8518d75db42d5c5e841fc4a4dbdcba30e1a9879e0<br />New hashes marked: 1<br /><=
br />Server Side:<br />{'mark': 'alive', 'where': {'taskhash': '9cd45da2fb6=
aa303a7828ec3cad7709bde2882422792e696016663f390aeece0'}}<br />{'mark': 'ali=
ve', 'where': {'taskhash': 'f1c4cca2ea1fc1181c40afc8518d75db42d5c5e841fc4a4=
dbdcba30e1a9879e0'}}<br />{'mark': 'alive', 'where': {'taskhash': 'f1c4cca2=
ea1fc1181c40afc8518d75db42d5c5e841fc4a4dbdcba30e1a9879e0'}}<br />{'mark': '=
alive', 'where': {'taskhash': '9cd45da2fb6aa303a7828ec3cad7709bde2882422792=
e696016663f390aeece0', 'taskhash2': 'f1c4cca2ea1fc1181c40afc8518d75db42d5c5=
e841fc4a4dbdcba30e1a9879e0'}}<br /><br />Perhaps I'm missing a something..<=
br />What I was proposing would be supporting something similar to this:<br=
 />Client Side:<br />$ ./bitbake-hashclient --address localhost:8688 gc-mar=
k alive --where 9cd45da f1c4cca<br /><br />Server Side:<br />{'mark': 'aliv=
e', 'where': {'taskhash': ['9cd45da', 'f1c4cca']}}</blockquote>
No, you aren't missing anything, I was incorrect :)<br /><br />There are 2 =
approaches here.<br /><br />The first would be to improve bitbake-hashclien=
t to add the input<br />stream command, but keep the existing API with the =
server. Each mark<br />sent through the file/pipe would result in a separat=
e `mark` command<br />being sent to the server. This should still be faster=
 since it will<br />reuse the same connection to the server as long as bitb=
ake-hashclient<br />is running, which will save the overhead of establishin=
g and<br />negotiating a connection. This also has the advantage that it do=
esn't<br />require server side changes, but it does mean a round-trip for e=
ach<br />`mark` command</blockquote>
</div>
<div>&nbsp;</div>
<div>I have a simple POC for this first approach, and seems to be working f=
ine.</div>
<div>I still need to test with the remote server to have a better sense of =
how</div>
<div>much faster it is, but based on my tests with a local server, I expect=
 it to</div>
<div>still be in the "minutes".</div>
<div><br />
<blockquote>The second is to make a new server API to allow streaming of ma=
rks.<br />The protocol between the client and server allows commands to go =
into<br />a "stream" mode (which to be clear is distinct from the "input st=
ream"<br />discussed above, the name overlap is unfortunate). This mode all=
ows<br />the client to send newline delimited messages as fast as it wants<=
br />(usually is some large batch size), and asynchronously read the<br />r=
esponses from the server (see send_stream_batch() in the client<br />code),=
 allowing multiple messages to be in-flight at once.<br />Implementing a ne=
w mark API on the server using this mechanism would<br />be the fastest pos=
sible way of communicating the marks. Of course the<br />disadvantage here =
is that it would require new API on the server, so a<br />server upgrade wo=
uld be required to use it. That said, it may be<br />possible to make bitba=
ke-hashclient intelligent enough to know if this<br />new API exists and if=
 so use it for the "input stream" and if not<br />fallback to the older mes=
sages as described above</blockquote>
</div>
<div>I haven't tried the "stream mode" yet, but had a quick look at the cod=
e and I</div>
<div>don't see any obvious reason for it not to work. :) so thanks!!</div>
<div>&nbsp;</div>
<div>I've been trying to tackle this "make bitbake-hashclient intelligent e=
nough to know</div>
<div>if this new API exists" and tbh I'm struggling a bit..</div>
<div>&nbsp;</div>
<div>Whenever I use a command that isn't available on the server I just get=
 "Error talking</div>
<div>to server: Connection closed". So far I'm not really seeing a way of g=
etting more</div>
<div>info on the particular error, and blindly assume a "connection closed"=
 means the</div>
<div>new API is not available does not seem right.</div>
<div>&nbsp;</div>
<div>I was thinking of adding a new command to the server to "request the A=
PI", or check</div>
<div>if a particular command is available, but that in itself changes the A=
PI :,)</div>
<div>so its a bit chicken and egg, which makes me think this might not be t=
he away to go..</div>
<div>&nbsp;</div>

--uzSEjyXFooEqO3wsiAq2--

