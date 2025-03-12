<h1>End-to-End AWS ECS Project</h1>

<h2> Project Overview </h2>

This AWS ECS end-to-end project involves deploying and running a Node.js goals-management application, which allows users to create and manage their own goals, to AWS ECS. The technologies I used were Terraform, Docker, AWS, GitHub Actions, and Node.js. Terraform modules were used to create code that was both reusable and adhered to standard practices when writing Terraform code. AWS services such as ECS, ECR, VPC, Route53, CloudWatch, and ACM were utilised for this project. Best practices were followed and implemented within the project, as you will see when we discussed some of the various static analysis tools I used to ensure my Terraform and Docker image addressed any vulnerabilities and adhered to best security practices. Git pre-commit hooks were also used to ensure Terraform code was scanned and adhered to best practices before being committed and pushed to GitHub.

<h2> Architectural diagram of project </h2>

<h2> Step 1: Running the node.js application on a container locally </h2>
We are going to be testing the application on a container running on our local machine before having it run on AWS ECS. To do this you will need to build the Docker image by creating a Dockerfile that will handle the application dependencies and setup needed for the app to work within the container:

```hcl
FROM node:22-alpine as Build

WORKDIR /app

COPY package.json .

COPY . .

RUN npm install

FROM node:22-alpine

WORKDIR /app

COPY --from=Build /app /app

EXPOSE 80

CMD ["node", "server.js"]
```

This Dockerfile takes advantage of multi-stage Docker builds to help optimise and speed up Docker image build times. This helps reduce the size of the image, thus saving storage.

To create the image run the following command:

```hcl
docker build -t goals-image:latest .
```

To start up the container using the Docker image you just built, run the following command:

```hcl
docker run -d -p 80:80 --name goals-container goals-image
```

Run `docker ps` to ensure that the container is up and running.

In order to access your container that you just started up you will have to connect to it through localhost - for example in this case: http://locahost:80.#

<Screenshot of application>

If you see this page it means you have successfully connected to your container on your localhost.

<h2> Step 2: Pushing Docker image to ECR </h2>



<mxfile host="app.diagrams.net" agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 Edg/134.0.0.0" version="26.1.0">
  <diagram name="Page-1" id="GIOHX4QoqLwrt3tFOdUO">
    <mxGraphModel dx="1426" dy="1958" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="827" pageHeight="1169" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />
        <mxCell id="M8O55_tZVBaM1rJx0aSC-2" value="Users" style="sketch=0;outlineConnect=0;fontColor=#232F3E;gradientColor=none;strokeColor=#232F3E;fillColor=#ffffff;dashed=0;verticalLabelPosition=bottom;verticalAlign=top;align=center;html=1;fontSize=12;fontStyle=0;aspect=fixed;shape=mxgraph.aws4.resourceIcon;resIcon=mxgraph.aws4.users;" vertex="1" parent="1">
          <mxGeometry x="10" y="280" width="60" height="60" as="geometry" />
        </mxCell>
        <mxCell id="M8O55_tZVBaM1rJx0aSC-35" value="" style="endArrow=classic;html=1;rounded=0;" edge="1" parent="1">
          <mxGeometry width="50" height="50" relative="1" as="geometry">
            <mxPoint x="720" y="270" as="sourcePoint" />
            <mxPoint x="720" y="270" as="targetPoint" />
            <Array as="points">
              <mxPoint x="720" y="270" />
            </Array>
          </mxGeometry>
        </mxCell>
        <mxCell id="M8O55_tZVBaM1rJx0aSC-36" value="" style="endArrow=classic;html=1;rounded=0;" edge="1" parent="1">
          <mxGeometry width="50" height="50" relative="1" as="geometry">
            <mxPoint x="730" y="280" as="sourcePoint" />
            <mxPoint x="730" y="280" as="targetPoint" />
            <Array as="points">
              <mxPoint x="730" y="280" />
            </Array>
          </mxGeometry>
        </mxCell>
        <mxCell id="M8O55_tZVBaM1rJx0aSC-14" value="Private subnet" style="points=[[0,0],[0.25,0],[0.5,0],[0.75,0],[1,0],[1,0.25],[1,0.5],[1,0.75],[1,1],[0.75,1],[0.5,1],[0.25,1],[0,1],[0,0.75],[0,0.5],[0,0.25]];outlineConnect=0;gradientColor=none;html=1;whiteSpace=wrap;fontSize=12;fontStyle=0;container=1;pointerEvents=0;collapsible=0;recursiveResize=0;shape=mxgraph.aws4.group;grIcon=mxgraph.aws4.group_security_group;grStroke=0;strokeColor=#00A4A6;fillColor=#E6F6F7;verticalAlign=top;align=left;spacingLeft=30;fontColor=#147EBA;dashed=0;direction=east;" vertex="1" parent="1">
          <mxGeometry x="960" y="50" width="140" height="140" as="geometry" />
        </mxCell>
        <mxCell id="M8O55_tZVBaM1rJx0aSC-19" value="Amazon ECS" style="sketch=0;outlineConnect=0;fontColor=#232F3E;gradientColor=none;strokeColor=#ffffff;fillColor=#232F3E;dashed=0;verticalLabelPosition=middle;verticalAlign=bottom;align=center;html=1;whiteSpace=wrap;fontSize=10;fontStyle=1;spacing=3;shape=mxgraph.aws4.productIcon;prIcon=mxgraph.aws4.ecs;" vertex="1" parent="M8O55_tZVBaM1rJx0aSC-14">
          <mxGeometry x="40" y="30" width="60" height="86.5" as="geometry" />
        </mxCell>
        <mxCell id="M8O55_tZVBaM1rJx0aSC-22" value="Private subnet" style="points=[[0,0],[0.25,0],[0.5,0],[0.75,0],[1,0],[1,0.25],[1,0.5],[1,0.75],[1,1],[0.75,1],[0.5,1],[0.25,1],[0,1],[0,0.75],[0,0.5],[0,0.25]];outlineConnect=0;gradientColor=none;html=1;whiteSpace=wrap;fontSize=12;fontStyle=0;container=1;pointerEvents=0;collapsible=0;recursiveResize=0;shape=mxgraph.aws4.group;grIcon=mxgraph.aws4.group_security_group;grStroke=0;strokeColor=#00A4A6;fillColor=#E6F6F7;verticalAlign=top;align=left;spacingLeft=30;fontColor=#147EBA;dashed=0;" vertex="1" parent="1">
          <mxGeometry x="960" y="515" width="140" height="140" as="geometry" />
        </mxCell>
        <mxCell id="M8O55_tZVBaM1rJx0aSC-23" value="Amazon ECS" style="sketch=0;outlineConnect=0;fontColor=#232F3E;gradientColor=none;strokeColor=#ffffff;fillColor=#232F3E;dashed=0;verticalLabelPosition=middle;verticalAlign=bottom;align=center;html=1;whiteSpace=wrap;fontSize=10;fontStyle=1;spacing=3;shape=mxgraph.aws4.productIcon;prIcon=mxgraph.aws4.ecs;" vertex="1" parent="M8O55_tZVBaM1rJx0aSC-22">
          <mxGeometry x="40" y="26" width="60" height="86.5" as="geometry" />
        </mxCell>
        <mxCell id="M8O55_tZVBaM1rJx0aSC-6" value="Application Load Balancer" style="sketch=0;outlineConnect=0;fontColor=#232F3E;gradientColor=none;strokeColor=#ffffff;fillColor=#232F3E;dashed=0;verticalLabelPosition=middle;verticalAlign=bottom;align=center;html=1;whiteSpace=wrap;fontSize=10;fontStyle=1;spacing=3;shape=mxgraph.aws4.productIcon;prIcon=mxgraph.aws4.application_load_balancer;" vertex="1" parent="1">
          <mxGeometry x="570" y="270" width="90" height="120" as="geometry" />
        </mxCell>
        <mxCell id="M8O55_tZVBaM1rJx0aSC-11" value="Public subnet" style="points=[[0,0],[0.25,0],[0.5,0],[0.75,0],[1,0],[1,0.25],[1,0.5],[1,0.75],[1,1],[0.75,1],[0.5,1],[0.25,1],[0,1],[0,0.75],[0,0.5],[0,0.25]];outlineConnect=0;gradientColor=none;html=1;whiteSpace=wrap;fontSize=12;fontStyle=0;container=1;pointerEvents=0;collapsible=0;recursiveResize=0;shape=mxgraph.aws4.group;grIcon=mxgraph.aws4.group_security_group;grStroke=0;strokeColor=#7AA116;fillColor=#F2F6E8;verticalAlign=top;align=left;spacingLeft=30;fontColor=#248814;dashed=0;" vertex="1" parent="1">
          <mxGeometry x="560" y="520" width="130" height="130" as="geometry" />
        </mxCell>
        <mxCell id="M8O55_tZVBaM1rJx0aSC-13" value="NAT gateway" style="sketch=0;outlineConnect=0;fontColor=#232F3E;gradientColor=none;strokeColor=#232F3E;fillColor=#ffffff;dashed=0;verticalLabelPosition=bottom;verticalAlign=top;align=center;html=1;fontSize=12;fontStyle=0;aspect=fixed;shape=mxgraph.aws4.resourceIcon;resIcon=mxgraph.aws4.nat_gateway;" vertex="1" parent="M8O55_tZVBaM1rJx0aSC-11">
          <mxGeometry x="34" y="35" width="60" height="60" as="geometry" />
        </mxCell>
        <mxCell id="M8O55_tZVBaM1rJx0aSC-10" value="Public subnet" style="points=[[0,0],[0.25,0],[0.5,0],[0.75,0],[1,0],[1,0.25],[1,0.5],[1,0.75],[1,1],[0.75,1],[0.5,1],[0.25,1],[0,1],[0,0.75],[0,0.5],[0,0.25]];outlineConnect=0;gradientColor=none;html=1;whiteSpace=wrap;fontSize=12;fontStyle=0;container=1;pointerEvents=0;collapsible=0;recursiveResize=0;shape=mxgraph.aws4.group;grIcon=mxgraph.aws4.group_security_group;grStroke=0;strokeColor=#7AA116;fillColor=#F2F6E8;verticalAlign=top;align=left;spacingLeft=30;fontColor=#248814;dashed=0;" vertex="1" parent="1">
          <mxGeometry x="550" y="50" width="130" height="130" as="geometry" />
        </mxCell>
        <mxCell id="M8O55_tZVBaM1rJx0aSC-29" value="NAT gateway" style="sketch=0;outlineConnect=0;fontColor=#232F3E;gradientColor=none;strokeColor=#232F3E;fillColor=#ffffff;dashed=0;verticalLabelPosition=bottom;verticalAlign=top;align=center;html=1;fontSize=12;fontStyle=0;aspect=fixed;shape=mxgraph.aws4.resourceIcon;resIcon=mxgraph.aws4.nat_gateway;" vertex="1" parent="M8O55_tZVBaM1rJx0aSC-10">
          <mxGeometry x="35" y="38.25" width="60" height="60" as="geometry" />
        </mxCell>
        <mxCell id="M8O55_tZVBaM1rJx0aSC-54" value="" style="endArrow=classic;html=1;rounded=0;" edge="1" parent="1" source="M8O55_tZVBaM1rJx0aSC-60">
          <mxGeometry width="50" height="50" relative="1" as="geometry">
            <mxPoint x="230" y="320" as="sourcePoint" />
            <mxPoint x="350" y="320" as="targetPoint" />
          </mxGeometry>
        </mxCell>
        <mxCell id="M8O55_tZVBaM1rJx0aSC-55" value="" style="endArrow=classic;html=1;rounded=0;" edge="1" parent="1">
          <mxGeometry width="50" height="50" relative="1" as="geometry">
            <mxPoint x="430" y="319.5" as="sourcePoint" />
            <mxPoint x="540" y="319.5" as="targetPoint" />
          </mxGeometry>
        </mxCell>
        <mxCell id="M8O55_tZVBaM1rJx0aSC-56" value="" style="endArrow=none;html=1;rounded=0;" edge="1" parent="1">
          <mxGeometry width="50" height="50" relative="1" as="geometry">
            <mxPoint x="670" y="319.5" as="sourcePoint" />
            <mxPoint x="1030" y="320" as="targetPoint" />
          </mxGeometry>
        </mxCell>
        <mxCell id="M8O55_tZVBaM1rJx0aSC-58" value="" style="endArrow=classic;html=1;rounded=0;entryX=0.5;entryY=1;entryDx=0;entryDy=0;" edge="1" parent="1" target="M8O55_tZVBaM1rJx0aSC-14">
          <mxGeometry width="50" height="50" relative="1" as="geometry">
            <mxPoint x="1029.5" y="320" as="sourcePoint" />
            <mxPoint x="1030" y="200" as="targetPoint" />
            <Array as="points" />
          </mxGeometry>
        </mxCell>
        <mxCell id="M8O55_tZVBaM1rJx0aSC-59" value="" style="endArrow=classic;html=1;rounded=0;" edge="1" parent="1">
          <mxGeometry width="50" height="50" relative="1" as="geometry">
            <mxPoint x="1029.5" y="320" as="sourcePoint" />
            <mxPoint x="1030" y="500" as="targetPoint" />
            <Array as="points" />
          </mxGeometry>
        </mxCell>
        <mxCell id="M8O55_tZVBaM1rJx0aSC-60" value="" style="shadow=0;dashed=0;html=1;strokeColor=none;fillColor=#4495D1;labelPosition=center;verticalLabelPosition=bottom;verticalAlign=top;align=center;outlineConnect=0;shape=mxgraph.veeam.dns;" vertex="1" parent="1">
          <mxGeometry x="170" y="295.2" width="44.8" height="44.8" as="geometry" />
        </mxCell>
        <mxCell id="M8O55_tZVBaM1rJx0aSC-61" value="" style="endArrow=classic;html=1;rounded=0;" edge="1" parent="1">
          <mxGeometry width="50" height="50" relative="1" as="geometry">
            <mxPoint x="60" y="316.645293761357" as="sourcePoint" />
            <mxPoint x="160" y="318.5629396325458" as="targetPoint" />
          </mxGeometry>
        </mxCell>
        <mxCell id="M8O55_tZVBaM1rJx0aSC-62" value="" style="endArrow=classic;html=1;rounded=0;" edge="1" parent="1">
          <mxGeometry width="50" height="50" relative="1" as="geometry">
            <mxPoint x="940" y="119.5" as="sourcePoint" />
            <mxPoint x="690" y="120" as="targetPoint" />
          </mxGeometry>
        </mxCell>
        <mxCell id="M8O55_tZVBaM1rJx0aSC-63" value="" style="endArrow=classic;html=1;rounded=0;" edge="1" parent="1">
          <mxGeometry width="50" height="50" relative="1" as="geometry">
            <mxPoint x="540" y="110" as="sourcePoint" />
            <mxPoint x="400" y="270" as="targetPoint" />
          </mxGeometry>
        </mxCell>
        <mxCell id="M8O55_tZVBaM1rJx0aSC-64" value="" style="endArrow=classic;html=1;rounded=0;exitX=0;exitY=0.2;exitDx=0;exitDy=0;exitPerimeter=0;" edge="1" parent="1" source="M8O55_tZVBaM1rJx0aSC-11">
          <mxGeometry width="50" height="50" relative="1" as="geometry">
            <mxPoint x="550" y="530" as="sourcePoint" />
            <mxPoint x="420" y="410" as="targetPoint" />
          </mxGeometry>
        </mxCell>
        <mxCell id="M8O55_tZVBaM1rJx0aSC-66" value="" style="endArrow=classic;html=1;rounded=0;" edge="1" parent="1">
          <mxGeometry width="50" height="50" relative="1" as="geometry">
            <mxPoint x="950" y="600" as="sourcePoint" />
            <mxPoint x="700" y="600.5" as="targetPoint" />
          </mxGeometry>
        </mxCell>
        <mxCell id="M8O55_tZVBaM1rJx0aSC-69" value="Availability zone" style="sketch=0;outlineConnect=0;gradientColor=none;html=1;whiteSpace=wrap;fontSize=12;fontStyle=0;shape=mxgraph.aws4.group;grIcon=mxgraph.aws4.group_availability_zone;strokeColor=#545B64;fillColor=none;verticalAlign=top;align=left;spacingLeft=30;fontColor=#545B64;dashed=1;" vertex="1" parent="1">
          <mxGeometry x="510" y="20" width="650" height="180" as="geometry" />
        </mxCell>
        <mxCell id="M8O55_tZVBaM1rJx0aSC-70" value="Internet&#xa;gateway" style="sketch=0;outlineConnect=0;fontColor=#232F3E;gradientColor=none;strokeColor=#232F3E;fillColor=#ffffff;dashed=0;verticalLabelPosition=bottom;verticalAlign=top;align=center;html=1;fontSize=12;fontStyle=0;aspect=fixed;shape=mxgraph.aws4.resourceIcon;resIcon=mxgraph.aws4.internet_gateway;" vertex="1" parent="1">
          <mxGeometry x="350" y="280" width="91.4" height="91.4" as="geometry" />
        </mxCell>
        <mxCell id="M8O55_tZVBaM1rJx0aSC-71" value="Availability zone" style="sketch=0;outlineConnect=0;gradientColor=none;html=1;whiteSpace=wrap;fontSize=12;fontStyle=0;shape=mxgraph.aws4.group;grIcon=mxgraph.aws4.group_availability_zone;strokeColor=#545B64;fillColor=none;verticalAlign=top;align=left;spacingLeft=30;fontColor=#545B64;dashed=1;" vertex="1" parent="1">
          <mxGeometry x="510" y="495" width="650" height="180" as="geometry" />
        </mxCell>
        <mxCell id="M8O55_tZVBaM1rJx0aSC-72" value="VPC" style="points=[[0,0],[0.25,0],[0.5,0],[0.75,0],[1,0],[1,0.25],[1,0.5],[1,0.75],[1,1],[0.75,1],[0.5,1],[0.25,1],[0,1],[0,0.75],[0,0.5],[0,0.25]];outlineConnect=0;gradientColor=none;html=1;whiteSpace=wrap;fontSize=12;fontStyle=0;container=1;pointerEvents=0;collapsible=0;recursiveResize=0;shape=mxgraph.aws4.group;grIcon=mxgraph.aws4.group_vpc2;strokeColor=#8C4FFF;fillColor=none;verticalAlign=top;align=left;spacingLeft=30;fontColor=#AAB7B8;dashed=0;" vertex="1" parent="1">
          <mxGeometry x="350" y="-140" width="1040" height="1020" as="geometry" />
        </mxCell>
        <mxCell id="M8O55_tZVBaM1rJx0aSC-67" value="Amazon Route 53" style="sketch=0;outlineConnect=0;fontColor=#232F3E;gradientColor=none;strokeColor=#ffffff;fillColor=#232F3E;dashed=0;verticalLabelPosition=middle;verticalAlign=bottom;align=center;html=1;whiteSpace=wrap;fontSize=10;fontStyle=1;spacing=3;shape=mxgraph.aws4.productIcon;prIcon=mxgraph.aws4.route_53;" vertex="1" parent="M8O55_tZVBaM1rJx0aSC-72">
          <mxGeometry x="20" y="830" width="80" height="110" as="geometry" />
        </mxCell>
        <mxCell id="M8O55_tZVBaM1rJx0aSC-74" value="Region" style="shape=mxgraph.ibm.box;prType=region;fontStyle=0;verticalAlign=top;align=left;spacingLeft=32;spacingTop=4;fillColor=none;rounded=0;whiteSpace=wrap;html=1;strokeColor=#919191;strokeWidth=2;dashed=0;container=1;spacing=-4;collapsible=0;expand=0;recursiveResize=0;" vertex="1" parent="1">
          <mxGeometry x="260" y="-180" width="1220" height="1180" as="geometry" />
        </mxCell>
      </root>
    </mxGraphModel>
  </diagram>
</mxfile>



