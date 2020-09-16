Subject: Re: [PATCH] bitbake: fetch/git: add support for SRC_URI containing spaces in url
To: bitbake-devel@lists.openembedded.org
From: "Charlie Davies" <charles.davies@whitetree.xyz>
X-Originating-Location: London, England, GB (185.192.70.189)
X-Originating-Platform: Linux Chrome 85
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Wed, 16 Sep 2020 14:28:14 -0700
References: <075098f5e21fc34a925187c6114206af92bbfd78.camel@linuxfoundation.org>
In-Reply-To: <075098f5e21fc34a925187c6114206af92bbfd78.camel@linuxfoundation.org>
Message-ID: <18836.1600291694255569397@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="An8lGA9JX0rkpetXdCWR"

--An8lGA9JX0rkpetXdCWR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I have added some unit tests and submitted v2 of the patch for your consid=
eration.

I added unit tests to test the uri parsing and the removal of spaces in th=
e filepaths. I didn't add a test for the addition of quotes in the git comm=
ands. The only method to test this that I could think of is to mock the run=
fetchmd. This seemed very invasive and looking at the rest of the tests not=
 in keeping with what has been done before. However, I ran a full build of =
my project overnight and there weren't any issues with the patch applied.

Yes, I agree the purpose of this patch would only be to cope with spaces i=
n the url of a repository.

Do I have to do anything else to have the patch merged into dunfell - if i=
t is accepted - as this is the branch of poky I am working from?

Many Thanks,

Charlie

--An8lGA9JX0rkpetXdCWR
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,<br /><br />I have added some unit tests and submitted v2 of the patch f=
or your consideration.<br /><br />I added unit tests to test the uri parsin=
g and the removal of spaces in the filepaths. I didn't add a test for the a=
ddition of quotes in the git commands. The only method to test this that I =
could think of is to mock the runfetchmd. This seemed very invasive and loo=
king at the rest of the tests not in keeping with what has been done before=
. However, I ran a full build of my project overnight and there weren't any=
 issues with the patch applied.<br /><br />Yes, I agree the purpose of this=
 patch would only be to cope with spaces in the url of a repository.<br /><=
br />Do I have to do anything else to have the patch merged into dunfell - =
if it is accepted - as this is the branch of poky I am working from?<br /><=
br />Many Thanks,<br /><br />Charlie

--An8lGA9JX0rkpetXdCWR--
