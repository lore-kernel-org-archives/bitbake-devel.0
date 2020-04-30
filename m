Subject: NPMSW fetcher fails if recipes concurrently fetch the same dependencies
To: bitbake-devel@lists.openembedded.org
From: scott.r.ware@intel.com
X-Originating-Location: Chipping Sodbury, England, GB (146.66.34.183)
X-Originating-Platform: Windows Chrome 81
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Thu, 30 Apr 2020 06:11:34 -0700
Message-ID: <SQOP.1588252294505167875.CgtT@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="NOpap8C9WdTrOp75ajrs"

--NOpap8C9WdTrOp75ajrs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I have updated several recipes to utilise the new npmsw fetcher: e.g. https=
://github.com/intel-iot-devkit/meta-iot-cloud/blob/master/recipes-node-red/=
node-red/node-red_1.0.2.bb

The recipes build fine in isolation but if you are building an image and m=
ultiple npm based recipes which have similar dependencies fetch in parallel=
 fetching fails.

My assumption is that if multiple npmsw fetch processes try and fetch the =
same dependency concurrently the processes start fighting over the download=
ed file in 'downloads/npm2' which then leads to checksum errors and failure=
s.

I think for npm dependency fetching with npmsw the downloads either need t=
o be tied to the package name or only allow a single npmsw fetching process=
 to occur at one time so the downloads can be re-used by other recipes.

--NOpap8C9WdTrOp75ajrs
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I have updated several recipes to utilise the new npmsw fetcher: e.g.&nbsp;=
<a href=3D"https://github.com/intel-iot-devkit/meta-iot-cloud/blob/master/r=
ecipes-node-red/node-red/node-red_1.0.2.bb">https://github.com/intel-iot-de=
vkit/meta-iot-cloud/blob/master/recipes-node-red/node-red/node-red_1.0.2.bb=
</a><br /><br />The recipes build fine in isolation but if you are building=
 an image and multiple npm based recipes which have similar dependencies fe=
tch in parallel fetching fails.<br /><br />My assumption is that if multipl=
e npmsw fetch processes try and fetch the same dependency concurrently the =
processes start fighting over the downloaded file in 'downloads/npm2' which=
 then leads to checksum errors and failures.<br /><br />I think for npm dep=
endency fetching with npmsw the downloads either need to be tied to the pac=
kage name or only allow a single npmsw fetching process to occur at one tim=
e so the downloads can be re-used by other recipes.

--NOpap8C9WdTrOp75ajrs--
