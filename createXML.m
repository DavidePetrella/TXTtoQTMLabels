function createXML(filename)

% Read the input list from the file
fid = fopen(filename, 'r');
inputList = textscan(fid, '%s');
inputList = inputList{1};
fclose(fid);

% Define the XML document structure
docNode = com.mathworks.xml.XMLUtils.createDocument('QTM_Label_List_Ver_1.00');
qtmLabelList = docNode.getDocumentElement();
trajectories = docNode.createElement('Trajectories');
qtmLabelList.appendChild(trajectories);

% Loop through the input list and add each trajectory
for i = 1:length(inputList)
    trajectory = docNode.createElement('Trajectory');
    trajectories.appendChild(trajectory);
    
    name = docNode.createElement('Name');
    name.appendChild(docNode.createTextNode(inputList{i}));
    trajectory.appendChild(name);
    
    color = docNode.createElement('Color');
    color.setAttribute('R', '0');
    color.setAttribute('G', '255');
    color.setAttribute('B', '0');
    trajectory.appendChild(color);
end

% Add the bones element
bones = docNode.createElement('Bones');
qtmLabelList.appendChild(bones);

color = docNode.createElement('Color');
color.setAttribute('R', '246');
color.setAttribute('G', '249');
color.setAttribute('B', '124');
bones.appendChild(color);

thickness = docNode.createElement('Thickness');
thickness.appendChild(docNode.createTextNode('20.000000'));
bones.appendChild(thickness);

% Write the XML document to a file
xmlFileName = 'labels.xml';
xmlwrite(xmlFileName, docNode);
type(xmlFileName);

end
