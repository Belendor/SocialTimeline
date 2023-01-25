import React from 'react';
import axios from 'axios';

export default class Form extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      value: '',
      selectedFile: '',
      setSelectedFile: {}
    };

    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
    this.handleFileSelect = this.handleFileSelect.bind(this);
  }

  handleChange(event) {
    this.setState({ value: event.target.value });
  }

    handleSubmit(event) {
        event.preventDefault();
      const data = new FormData();
      console.log(this.state.setSelectedFile);
    data.append('file', this.state.setSelectedFile);
    data.append('title', this.state.value);
    let url = 'http://localhost:5000/submit';

    axios
      .post(url, data, {
        headers: {
          'Content-Type': 'multipart/form-data'
        }
      })
      .then((res) => {
        // then print response status
        console.warn(res);
      });

    // alert('A name was submitted: ' + this.state.value);

  }
  handleFileSelect(event) {
      this.setState({ setSelectedFile: event.target.files[0] });
  }

  render() {
    return (
      <form onSubmit={this.handleSubmit}>
        <label>
          Name:
          <input
            type="text"
            value={this.state.value}
            onChange={this.handleChange}
          />
        </label>
        <input type="file" onChange={this.handleFileSelect} />
        <input type="submit" value="Submit" />
      </form>
    );
  }
}